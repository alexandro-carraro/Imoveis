-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Tempo de geração: 29/08/2025 às 14:54
-- Versão do servidor: 10.4.32-MariaDB
-- Versão do PHP: 8.2.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Banco de dados: `imoveis`
--

-- --------------------------------------------------------

--
-- Estrutura para tabela `cliente`
--

CREATE TABLE `cliente` (
  `id_cliente` int(11) NOT NULL,
  `nome_cliente` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

--
-- Despejando dados para a tabela `cliente`
--

INSERT INTO `cliente` (`id_cliente`, `nome_cliente`) VALUES
(1, 'Ana Silva'),
(2, 'Bruno Costa'),
(3, 'Carlos Oliveira'),
(4, 'Daniela Souza'),
(5, 'Eduardo Lima'),
(6, 'Fernanda Rocha'),
(7, 'Gabriel Martins'),
(8, 'Helena Santos');

-- --------------------------------------------------------

--
-- Estrutura para tabela `imovel`
--

CREATE TABLE `imovel` (
  `id_imovel` int(11) NOT NULL,
  `codigo_imovel` varchar(20) NOT NULL,
  `descricao` varchar(100) NOT NULL,
  `id_tipo` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

--
-- Despejando dados para a tabela `imovel`
--

INSERT INTO `imovel` (`id_imovel`, `codigo_imovel`, `descricao`, `id_tipo`) VALUES
(1, 'IMV001', 'Apartamento 2 quartos - Centro', 1),
(2, 'IMV002', 'Casa 3 quartos - Bairro Sul', 2),
(3, 'IMV003', 'Sala Comercial 40m² - Centro', 3),
(4, 'IMV004', 'Terreno 200m² - Bairro Norte', 4),
(5, 'IMV005', 'Kitnet mobiliada - Próx. Univ.', 5),
(6, 'IMV006', 'Apartamento 3 quartos - Beira Mar', 1),
(7, 'IMV007', 'Casa 2 quartos - Bairro Oeste', 2),
(8, 'IMV008', 'Sala Comercial 60m² - Centro', 3);

-- --------------------------------------------------------

--
-- Estrutura para tabela `pagamento`
--

CREATE TABLE `pagamento` (
  `id_venda` int(11) NOT NULL,
  `data_pagamento` date NOT NULL,
  `mes` int(11) NOT NULL,
  `ano` int(11) NOT NULL,
  `valor_pagamento` decimal(10,2) NOT NULL,
  `id_imovel` int(11) NOT NULL,
  `id_cliente` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

--
-- Despejando dados para a tabela `pagamento`
--

INSERT INTO `pagamento` (`id_venda`, `data_pagamento`, `mes`, `ano`, `valor_pagamento`, `id_imovel`, `id_cliente`) VALUES
(1, '2022-11-05', 11, 2022, 1200.00, 1, 1),
(2, '2022-11-15', 11, 2022, 800.00, 2, 2),
(3, '2022-11-20', 11, 2022, 1500.00, 3, 3),
(4, '2022-11-25', 11, 2022, 500.00, 4, 4),
(5, '2022-12-01', 12, 2022, 1300.00, 5, 5),
(6, '2022-12-05', 12, 2022, 2000.00, 6, 6),
(7, '2022-12-10', 12, 2022, 900.00, 7, 7),
(8, '2022-12-18', 12, 2022, 1600.00, 8, 8),
(9, '2023-01-03', 1, 2023, 1200.00, 1, 1),
(10, '2023-01-07', 1, 2023, 800.00, 2, 2),
(11, '2023-01-11', 1, 2023, 2000.00, 3, 3),
(12, '2023-01-16', 1, 2023, 600.00, 4, 4),
(13, '2023-01-21', 1, 2023, 1300.00, 5, 5),
(14, '2023-01-27', 1, 2023, 1500.00, 6, 6),
(15, '2023-01-29', 1, 2023, 950.00, 7, 7),
(16, '2023-02-04', 2, 2023, 1700.00, 8, 8),
(17, '2023-02-09', 2, 2023, 1400.00, 1, 1),
(18, '2023-02-13', 2, 2023, 850.00, 2, 2),
(19, '2023-02-20', 2, 2023, 1900.00, 3, 3),
(20, '2023-02-23', 2, 2023, 700.00, 4, 4),
(21, '2023-02-28', 2, 2023, 1350.00, 5, 5),
(22, '2023-03-03', 3, 2023, 2200.00, 6, 6),
(23, '2023-03-08', 3, 2023, 970.00, 7, 7),
(24, '2023-03-15', 3, 2023, 1800.00, 8, 8),
(25, '2023-03-21', 3, 2023, 1600.00, 1, 1),
(26, '2023-03-25', 3, 2023, 1100.00, 2, 2),
(27, '2023-03-28', 3, 2023, 2000.00, 3, 3),
(28, '2023-03-30', 3, 2023, 650.00, 4, 4),
(29, '2023-03-31', 3, 2023, 1450.00, 5, 5),
(30, '2023-03-31', 3, 2023, 2300.00, 6, 6);

-- --------------------------------------------------------

--
-- Estrutura para tabela `tipo_imovel`
--

CREATE TABLE `tipo_imovel` (
  `id_tipo` int(11) NOT NULL,
  `nome` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

--
-- Despejando dados para a tabela `tipo_imovel`
--

INSERT INTO `tipo_imovel` (`id_tipo`, `nome`) VALUES
(1, 'Apartamento'),
(2, 'Casa'),
(3, 'Sala Comercial'),
(4, 'Terreno'),
(5, 'Kitnet');

--
-- Índices para tabelas despejadas
--

--
-- Índices de tabela `cliente`
--
ALTER TABLE `cliente`
  ADD PRIMARY KEY (`id_cliente`);

--
-- Índices de tabela `imovel`
--
ALTER TABLE `imovel`
  ADD PRIMARY KEY (`id_imovel`),
  ADD UNIQUE KEY `codigo_imovel` (`codigo_imovel`),
  ADD KEY `id_tipo` (`id_tipo`);

--
-- Índices de tabela `pagamento`
--
ALTER TABLE `pagamento`
  ADD PRIMARY KEY (`id_venda`),
  ADD KEY `id_imovel` (`id_imovel`),
  ADD KEY `id_cliente` (`id_cliente`);

--
-- Índices de tabela `tipo_imovel`
--
ALTER TABLE `tipo_imovel`
  ADD PRIMARY KEY (`id_tipo`);

--
-- AUTO_INCREMENT para tabelas despejadas
--

--
-- AUTO_INCREMENT de tabela `cliente`
--
ALTER TABLE `cliente`
  MODIFY `id_cliente` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- AUTO_INCREMENT de tabela `imovel`
--
ALTER TABLE `imovel`
  MODIFY `id_imovel` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- AUTO_INCREMENT de tabela `pagamento`
--
ALTER TABLE `pagamento`
  MODIFY `id_venda` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=31;

--
-- AUTO_INCREMENT de tabela `tipo_imovel`
--
ALTER TABLE `tipo_imovel`
  MODIFY `id_tipo` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- Restrições para tabelas despejadas
--

--
-- Restrições para tabelas `imovel`
--
ALTER TABLE `imovel`
  ADD CONSTRAINT `imovel_ibfk_1` FOREIGN KEY (`id_tipo`) REFERENCES `tipo_imovel` (`id_tipo`);

--
-- Restrições para tabelas `pagamento`
--
ALTER TABLE `pagamento`
  ADD CONSTRAINT `pagamento_ibfk_1` FOREIGN KEY (`id_imovel`) REFERENCES `imovel` (`id_imovel`),
  ADD CONSTRAINT `pagamento_ibfk_2` FOREIGN KEY (`id_cliente`) REFERENCES `cliente` (`id_cliente`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
