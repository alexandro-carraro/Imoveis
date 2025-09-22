// index.js (com as rotas da Parte 2) - versão ajustada
const mysql = require('mysql');
const express = require('express');

const app = express();
const PORT = process.env.PORT || 80;
app.listen(PORT, () => console.log(`API rodando na porta ${PORT}`));

const MYSQL_IP = "localhost";
const MYSQL_LOGIN = "root";
const MYSQL_PASSWORD = "";

let con = mysql.createConnection({
  host: MYSQL_IP,
  user: MYSQL_LOGIN,
  password: MYSQL_PASSWORD,
  database: "imoveis"
});

con.connect(function (err) {
  if (err) {
    console.log("Erro conexão MySQL:", err);
    throw err;
  }
  console.log("Connection with mysql established");
});

console.log("API - Banco de Dados 'imoveis' rodando");

/*
// ***** PARTE 1
// Exemplo - acumulado por cliente
function showGoldCustomers() {
  let sql = `
    SELECT p.id_venda,
           p.valor_pagamento AS amount,
           p.mes,
           p.ano,
           c.id_cliente,
           c.nome_cliente
    FROM pagamento p
    JOIN cliente c ON c.id_cliente = p.id_cliente
  `;
  con.query(sql, function (err, result) {
    if (err) {
      console.log(err);
    } else {
      let totalPerCustomer = new Map();

      result.forEach(record => {
        if (totalPerCustomer.get(record['id_cliente']) === undefined) {
          totalPerCustomer.set(record['id_cliente'], {
            value: record['amount'],
            cliente: record['id_cliente'],
            cliente_nome: record['nome_cliente'],
            total_pagamentos: 1
          });
        } else {
          totalPerCustomer.get(record['id_cliente']).value += record['amount'];
          totalPerCustomer.get(record['id_cliente']).total_pagamentos += 1;
        }
      });

      let arrayTotalPerCustomer = Array.from(totalPerCustomer.values());
      console.log("arrayTotalPerCustomer", arrayTotalPerCustomer);
    }
  });
}

// Exemplo - total por mês/ano
function showTotalPerMonthYear() {
  let sql = `
    SELECT p.valor_pagamento AS amount,
           p.mes,
           p.ano
    FROM pagamento p
  `;
  con.query(sql, function (err, result) {
    if (err) {
      console.log(err);
    } else {
      let totalPerMonth = new Map();

      result.forEach(record => {
        let periodKey = record['ano'] + "_" + record['mes'];
        if (totalPerMonth.get(periodKey) === undefined) {
          totalPerMonth.set(periodKey, {
            value: record['amount'],
            year: record['ano'],
            month: record['mes']
          });
        } else {
          totalPerMonth.get(periodKey).value += record['amount'];
        }
      });
      console.log(totalPerMonth);
    }
  });
}
*/

// ***** PARTE 2
// helper: set CORS headers (uso replicado; para projeto maior, coloque como middleware)
function setCorsHeaders(res) {
  res.setHeader('Content-Type', 'application/json');
  res.setHeader("Access-Control-Allow-Origin", "*");
  res.setHeader("Access-Control-Allow-Methods","POST,GET,OPTIONS,PUT,DELETE,HEAD");
  res.setHeader("Access-Control-Allow-Headers","X-PINGOTHER,Origin,X-Requested-With,Content-Type,Accept");
  res.setHeader("Access-Control-Max-Age","1728000");
}

// (a) Soma de todos os pagamentos por id_imovel
app.get('/payments_per_imovel', function (req, res) {
  let sql = `SELECT id_imovel, valor_pagamento FROM pagamento`;
  con.query(sql, function (err, result) {
    if (err) {
      res.status(500);
      res.send(JSON.stringify(err));
      return;
    }
    let totalPerImovel = new Map();

    result.forEach(record => {
      let imovelId = record['id_imovel'];
      let amount = parseFloat(record['valor_pagamento']) || 0;
      if (totalPerImovel.get(imovelId) === undefined) {
        totalPerImovel.set(imovelId, {
          id_imovel: imovelId,
          total_valor: amount
        });
      } else {
        totalPerImovel.get(imovelId).total_valor += amount;
      }
    });

    let arrayTotalPerImovel = Array.from(totalPerImovel.values());

    res.status(200);
    setCorsHeaders(res);
    res.send(JSON.stringify(arrayTotalPerImovel));
  });
});

// (b) Total de vendas por mês/ano
app.get('/payments_per_month_year', function (req, res) {
  let sql = `SELECT mes, ano, valor_pagamento FROM pagamento`;
  con.query(sql, function (err, result) {
    if (err) {
      res.status(500);
      res.send(JSON.stringify(err));
      return;
    }
    let totalPerPeriod = new Map();

    result.forEach(record => {
      let month = Number(record['mes']);
      let year = Number(record['ano']);
      let amount = parseFloat(record['valor_pagamento']) || 0;
      let periodKey = String(month).padStart(2, '0') + '/' + String(year);

      if (totalPerPeriod.get(periodKey) === undefined) {
        totalPerPeriod.set(periodKey, {
          period: periodKey,
          year: year,
          month: month,
          total_valor: amount
        });
      } else {
        totalPerPeriod.get(periodKey).total_valor += amount;
      }
    });

    let arrayTotalPerPeriod = Array.from(totalPerPeriod.values())
      .sort((a, b) => {
        if (Number(a.year) !== Number(b.year)) return Number(a.year) - Number(b.year);
        return Number(a.month) - Number(b.month);
      });

    res.status(200);
    setCorsHeaders(res);
    res.send(JSON.stringify(arrayTotalPerPeriod));
  });
});

// (c) Proporção percentual (quantitativa) de cada tipo de imóvel no total de vendas (contagem de pagamentos)
app.get('/types_proportion', function (req, res) {
  let sql = `
    SELECT t.id_tipo, t.nome AS tipo_nome
    FROM pagamento p
    JOIN imovel i ON i.id_imovel = p.id_imovel
    JOIN tipo_imovel t ON t.id_tipo = i.id_tipo
  `;
  con.query(sql, function (err, result) {
    if (err) {
      res.status(500);
      res.send(JSON.stringify(err));
      return;
    }
    let totalPerType = new Map();
    let totalElements = result.length;

    result.forEach(record => {
      let tipoId = record['id_tipo'];
      let tipoNome = record['tipo_nome'] || 'Desconhecido';
      if (totalPerType.get(tipoId) === undefined) {
        totalPerType.set(tipoId, {
          id_tipo: tipoId,
          tipo: tipoNome,
          count: 1
        });
      } else {
        totalPerType.get(tipoId).count++;
      }
    });

    let arrayTotalPerType = Array.from(totalPerType.values());

    arrayTotalPerType = arrayTotalPerType.map(el => {
      el.percentage = totalElements > 0 ? Number(((el.count / totalElements) * 100).toFixed(2)) : 0;
      return el;
    });

    res.status(200);
    setCorsHeaders(res);
    res.send(JSON.stringify(arrayTotalPerType));
  });
});
