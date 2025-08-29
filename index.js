const mysql = require('mysql'); 
const express = require('express');

const app = express();
app.listen(80);

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
    console.log(err);
    throw err;
  }
  console.log("Connection with mysql established");
});

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

console.log("API - Banco de Dados 'imoveis' rodando");
showGoldCustomers();