use 'CHANGE-ME';

CREATE TABLE IF NOT EXISTS `job_tax` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `job_name` varchar(50) NOT NULL,
  `tax_percent` decimal(5,2) NOT NULL DEFAULT '0.00',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

INSERT INTO `job_tax` (`job_name`, `tax_percent`) VALUES
('unemployed', 0.00),
('police', 0.10),
('ambulance', 0.10),
('mechanic', 0.05),
('taxi', 0.15),
('cardealer', 0.05),
('reporter', 0.15),
('judge', 0.10),
('lawyer', 0.10),
('realestate', 0.10),
('bus', 0.10),
('trucker', 0.10),
('tow', 0.10),
('garbage', 0.10),
('vineyard', 0.10),
('hotdog', 0.10),
('mayor', 0.20);