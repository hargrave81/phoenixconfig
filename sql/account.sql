
CREATE TABLE account_ip_record (
  login_time datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  accid int(10) NOT NULL,
  charid int(10) NOT NULL,
  client_ip tinytext NOT NULL,
  PRIMARY KEY (login_time,accid)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
