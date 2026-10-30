create database hotel_api;
use hotel_api;

create table hospedes (
	id INT PRIMARY KEY AUTO_INCREMENT,
    nome VARCHAR(150) NOT NULL,
	cpf VARBINARY(32) NOT NULL,
    cpf_iv BINARY(12) NOT NULL,
    cpf_tag BINARY(16) NOT NULL,
    data_nascimento DATE NOT NULL,
    telefone BIGINT NOT NULL UNIQUE,
    endereco VARCHAR(150) NOT NULL,
    email VARCHAR(150) NOT NULL UNIQUE,
    senha_hash BINARY(64) NOT NULL,
    senha_salt BINARY(16) NOT NULL
);

create table quartos (
	id INT PRIMARY KEY AUTO_INCREMENT,
    numero_quarto INT NOT NULL UNIQUE,
    quantidade_quartos INT NOT NULL,
    descricao VARCHAR(300) NOT NULL,
	status_quarto VARCHAR(50) NOT NULL
);

create table reservas (
		id 	INT PRIMARY KEY AUTO_INCREMENT,
        id_quarto INT,
        id_hospede INT,
        data_entrada DATETIME NOT NULL,
        data_saida DATETIME,
        CONSTRAINT fk_quarto_id FOREIGN KEY (id_quarto) REFERENCES quartos(id),
        CONSTRAINT fk_hospede_id FOREIGN KEY (id_hospede) REFERENCES hospedes(id)
);

INSERT INTO hospedes (
    nome, 
    cpf, 
    cpf_iv, 
    cpf_tag, 
    data_nascimento, 
    telefone, 
    endereco, 
    email, 
    senha_hash, 
    senha_salt
) VALUES 
(
    'Mariana Souza',
    UNHEX('4a6173df890b12c4e567a8b9c0d1e2f3'),         -- Criptograma AES (VARBINARY 16-32 bytes)
    UNHEX('1234567890abcdef12345678'),                 -- IV AES-GCM (12 bytes / 24 hex chars)
    UNHEX('abcdef0123456789abcdef0123456789'),         -- Tag de autenticação (16 bytes / 32 hex chars)
    '1992-04-12',
    5511998765432,
    'Av. Paulista, 1578, Apto 42 - São Paulo, SP',
    'mariana.souza@email.com',
    UNHEX(SHA2('SenhaForte@2026', 512)),               -- Hash SHA-512 (64 bytes / 128 hex chars)
    UNHEX(MD5('salt_exemplo_1'))                       -- Salt (16 bytes / 32 hex chars)
),
(
    'Lucas Mendes',
    UNHEX('8b7c6d5e4f3a2b1c0d9e8f7a6b5c4d3e'),
    UNHEX('abcdef1234567890abcdef12'),
    UNHEX('0123456789abcdef0123456789abcdef'),
    '1988-09-27',
    5521987654321,
    'Rua Barata Ribeiro, 200 - Rio de Janeiro, RJ',
    'lucas.mendes@email.com',
    UNHEX(SHA2('OutraSenhaSegura#', 512)),
    UNHEX(MD5('salt_exemplo_2'))
);

-- 2. Inserção de Quartos
-- Atenção: A coluna status_quarto possui restrição UNIQUE no schema original,
-- exigindo que cada quarto cadastrado tenha um status com texto diferente.
INSERT INTO quartos (
    numero_quarto, 
    quantidade_quartos, 
    descricao, 
    status_quarto
) VALUES 
(101, 1, 'Quarto Standard com 1 cama de casal e ar-condicionado', 'Disponível'),
(102, 2, 'Suíte Master com 2 quartos, varanda e hidromassagem', 'Ocupado'),
(201, 1, 'Quarto Executivo com mesa de trabalho e frigobar', 'Em Manutenção');

-- 3. Inserção de Reservas
INSERT INTO reservas (
    id_quarto, 
    id_hospede, 
    data_entrada, 
    data_saida
) VALUES 
(1, 1, '2026-11-05 14:00:00', '2026-11-10 11:00:00'),
(2, 2, '2026-11-01 15:30:00', '2026-11-06 10:00:00'),
(1, 2, '2026-12-20 14:00:00', NULL); -- Check-out em aberto / reserva futura