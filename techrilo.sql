-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: localhost
-- Tempo de geração: 22/11/2023 às 18:03
-- Versão do servidor: 8.0.34
-- Versão do PHP: 8.2.11

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Banco de dados: `techrilo`
--

-- --------------------------------------------------------

--
-- Estrutura para tabela `endereco`
--

CREATE TABLE `endereco` (
  `idendereco` int NOT NULL,
  `cep` text NOT NULL,
  `rua` text,
  `bairro` text NOT NULL,
  `cidade` text NOT NULL,
  `uf` text NOT NULL,
  `ibge` int DEFAULT NULL,
  `iduser` int NOT NULL,
  `criado` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Despejando dados para a tabela `endereco`
--

INSERT INTO `endereco` (`idendereco`, `cep`, `rua`, `bairro`, `cidade`, `uf`, `ibge`, `iduser`, `criado`) VALUES
(1, '08420-650', NULL, 'Jardim São Pedro', 'São Paulo', 'SP', NULL, 6, '2023-11-22 00:59:38'),
(2, '08420-650', NULL, 'Jardim São Pedro', 'São Paulo', 'SP', NULL, 7, '2023-11-22 01:35:48'),
(3, '08420-650', NULL, 'Jardim São Pedro', 'São Paulo', 'SP', NULL, 8, '2023-11-22 13:19:40');

-- --------------------------------------------------------

--
-- Estrutura para tabela `log_produto`
--

CREATE TABLE `log_produto` (
  `id` int NOT NULL,
  `id_produto` int NOT NULL,
  `acao` text NOT NULL,
  `mensagem` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Despejando dados para a tabela `log_produto`
--

INSERT INTO `log_produto` (`id`, `id_produto`, `acao`, `mensagem`) VALUES
(1, 1, 'Produto deletado', 'NOME:xxx, preco10, quantidade:10');

-- --------------------------------------------------------

--
-- Estrutura para tabela `log_users`
--

CREATE TABLE `log_users` (
  `id` int NOT NULL,
  `id_user` int NOT NULL,
  `acao` text NOT NULL,
  `mensagem` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- --------------------------------------------------------

--
-- Estrutura para tabela `perfil`
--

CREATE TABLE `perfil` (
  `id` int NOT NULL,
  `id_user` int NOT NULL,
  `tipo` text NOT NULL,
  `criado` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- --------------------------------------------------------

--
-- Estrutura para tabela `produtos`
--

CREATE TABLE `produtos` (
  `id` int NOT NULL,
  `nome` text NOT NULL,
  `preco` text NOT NULL,
  `quantidade` int NOT NULL,
  `criado` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Despejando dados para a tabela `produtos`
--

INSERT INTO `produtos` (`id`, `nome`, `preco`, `quantidade`, `criado`) VALUES
(2, 'xxy', '10', 10, '2023-11-21 22:54:01'),
(3, 'xxxx', '10', 10, '2023-11-21 22:55:38'),
(4, 'xxxxx', '10', 10, '2023-11-22 12:51:13');

--
-- Acionadores `produtos`
--
DELIMITER $$
CREATE TRIGGER `DeleteProd` AFTER DELETE ON `produtos` FOR EACH ROW BEGIN INSERT INTO log_produto(id_produto,acao, mensagem)VALUES (OLD.id, 'Produto deletado', CONCAT('NOME:', OLD.nome, ', preco', OLD.preco, ', quantidade:', OLD.quantidade )); END
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `updateProd` AFTER UPDATE ON `produtos` FOR EACH ROW BEGIN INSERT INTO log_produto(id_produto,acao, mensagem)VALUES (OLD.id, 'Produto Atualizado', CONCAT('NOME ANTIGO:', OLD.nome, ', preco Antigo', OLD.preco, ', quantidade antiga:', OLD.quantidade )); END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Estrutura para tabela `users`
--

CREATE TABLE `users` (
  `id` int NOT NULL,
  `nome` text NOT NULL,
  `email` text NOT NULL,
  `senha` varchar(255) NOT NULL,
  `datanascimento` datetime DEFAULT NULL,
  `criado` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `perfil` varchar(45) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Despejando dados para a tabela `users`
--

INSERT INTO `users` (`id`, `nome`, `email`, `senha`, `datanascimento`, `criado`, `perfil`) VALUES
(1, 'Vendedor', 'xxx@Xxxx', 'xxx', '2023-11-22 01:51:15', '2023-11-21 22:52:42', 'X'),
(2, 'ADM User', 'xxx@xxx', 'xxx', '2023-11-22 01:51:15', '2023-11-21 22:52:42', 'Y'),
(3, 'xxx', 'xxxx@xxx', '$2y$10$QtLnghNKB/ul4OQjJgcUyunEXwrk8dSrZOeKTSP.NXMs2XCntrogS', NULL, '2023-11-22 00:49:28', 'X'),
(4, 'xxxxxx', 'xxx@xxxxxx', '$2y$10$6GU4AAEMqn30ky2xyqfU3.cRtsDrZxiznj5Sw9/krFHFzu1/9MRdO', NULL, '2023-11-22 00:54:01', 'X'),
(5, 'xxxxxxxxxx', 'xxxx@xxxx', '$2y$10$5kx49EEhoCga6GzMHb4pjePu8gtXJFkzy/xhpuU1RBjIW0SaXl9Iy', NULL, '2023-11-22 00:57:42', 'Y'),
(6, 'xxxxxxxx', 'xxxx@xxxxxxx', '$2y$10$7Ofykn1r8GIcMhmazVYeV.pfImfcPYbEU5eewmyzLJq45X8w/yvJm', NULL, '2023-11-22 00:59:38', 'X'),
(7, 'xxx', 'xxx@xxxxx', '$2y$10$rY5HI2WUvVevNjU0L0KmNeYiW51iJSpRcSeAQ0W8C9YnzqH5h7Pk6', NULL, '2023-11-22 01:35:48', 'X'),
(8, 'xxxxxxxxxxxxx', 'xx@xx', '$2y$10$6y0p932paqD9EwU7xhN1TuIPr9LaKq6HQORH02pjiKeJW.zoX3hOG', NULL, '2023-11-22 13:19:40', 'Y');

--
-- Acionadores `users`
--
DELIMITER $$
CREATE TRIGGER `DeleteUser` AFTER DELETE ON `users` FOR EACH ROW BEGIN
INSERT INTO log_users(id_user,acao, mensagem)VALUES 
(OLD.id, 'Usuario deletado', CONCAT('NOME:', OLD.nome, ', email', OLD.email, ', senha:', OLD.senha, ', perfil: ', OLD.perfil  ));
END
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `updateUser` AFTER UPDATE ON `users` FOR EACH ROW BEGIN INSERT INTO log_users(id_user,acao, mensagem)VALUES (OLD.id, 'Usuario Atualizado', CONCAT('NOME ANNTIGO:', OLD.nome, ', email ANTIGO', OLD.email, ', senha antiga:', OLD.senha, ', perfil antigo: ', OLD.perfil )); END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Estrutura para tabela `vendas`
--

CREATE TABLE `vendas` (
  `id` int NOT NULL,
  `id_user` int NOT NULL,
  `id_produto` int NOT NULL,
  `data_cadastrado` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Índices para tabelas despejadas
--

--
-- Índices de tabela `endereco`
--
ALTER TABLE `endereco`
  ADD PRIMARY KEY (`idendereco`),
  ADD KEY `iduser_idx` (`iduser`);

--
-- Índices de tabela `log_produto`
--
ALTER TABLE `log_produto`
  ADD PRIMARY KEY (`id`);

--
-- Índices de tabela `perfil`
--
ALTER TABLE `perfil`
  ADD PRIMARY KEY (`id`);

--
-- Índices de tabela `produtos`
--
ALTER TABLE `produtos`
  ADD PRIMARY KEY (`id`);

--
-- Índices de tabela `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`);

--
-- Índices de tabela `vendas`
--
ALTER TABLE `vendas`
  ADD PRIMARY KEY (`id`),
  ADD KEY `idUser_idx` (`id_user`),
  ADD KEY `id_produto_idx` (`id_produto`);

--
-- AUTO_INCREMENT para tabelas despejadas
--

--
-- AUTO_INCREMENT de tabela `endereco`
--
ALTER TABLE `endereco`
  MODIFY `idendereco` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT de tabela `log_produto`
--
ALTER TABLE `log_produto`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT de tabela `perfil`
--
ALTER TABLE `perfil`
  MODIFY `id` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de tabela `produtos`
--
ALTER TABLE `produtos`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT de tabela `users`
--
ALTER TABLE `users`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- AUTO_INCREMENT de tabela `vendas`
--
ALTER TABLE `vendas`
  MODIFY `id` int NOT NULL AUTO_INCREMENT;

--
-- Restrições para tabelas despejadas
--

--
-- Restrições para tabelas `endereco`
--
ALTER TABLE `endereco`
  ADD CONSTRAINT `iduser` FOREIGN KEY (`iduser`) REFERENCES `users` (`id`);

--
-- Restrições para tabelas `vendas`
--
ALTER TABLE `vendas`
  ADD CONSTRAINT `id_produto` FOREIGN KEY (`id_produto`) REFERENCES `produtos` (`id`),
  ADD CONSTRAINT `id_user` FOREIGN KEY (`id_user`) REFERENCES `users` (`id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
