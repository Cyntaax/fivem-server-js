CREATE TABLE `tebex_transactions` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `identifier` text,
  `txn_id` text,
  `processed` tinyint(1) DEFAULT NULL,
  `tx_data` longtext,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=latin1