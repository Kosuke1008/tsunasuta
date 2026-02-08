-- ============================================
-- tsunasuta 初期データベース構築スクリプト
-- ============================================

CREATE DATABASE IF NOT EXISTS tsunasuta
  DEFAULT CHARACTER SET utf8mb4
  DEFAULT COLLATE utf8mb4_general_ci;

USE tsunasuta;

-- ============================================
-- users（会員情報）
-- ============================================
CREATE TABLE users (
  id INT AUTO_INCREMENT PRIMARY KEY,
  username VARCHAR(255) NOT NULL,
  birthdate DATE,
  student_type ENUM('小','中','高','専','大') NOT NULL,
  graduation_year INT,
  email VARCHAR(255) NOT NULL UNIQUE,
  password VARCHAR(255) NOT NULL,
  receive_notice BOOLEAN DEFAULT FALSE,
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP
);

-- ============================================
-- reservations（予約）
-- ============================================
CREATE TABLE reservations (
  id INT AUTO_INCREMENT PRIMARY KEY,
  user_id INT NOT NULL,
  date DATE NOT NULL,
  start_time TIME NOT NULL,
  end_time TIME NOT NULL,
  purpose TEXT,
  status ENUM('予約済','キャンセル') DEFAULT '予約済',
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
  FOREIGN KEY (user_id) REFERENCES users(id)
);

-- ============================================
-- entry_logs（入退室ログ）
-- ============================================
CREATE TABLE entry_logs (
  id INT AUTO_INCREMENT PRIMARY KEY,
  user_id INT NOT NULL,
  action ENUM('入室','退室') NOT NULL,
  timestamp DATETIME DEFAULT CURRENT_TIMESTAMP,
  FOREIGN KEY (user_id) REFERENCES users(id)
);

-- ============================================
-- admin_users（管理者）
-- ============================================
CREATE TABLE admin_users (
  id INT AUTO_INCREMENT PRIMARY KEY,
  username VARCHAR(255) NOT NULL,
  email VARCHAR(255) NOT NULL UNIQUE,
  password VARCHAR(255) NOT NULL,
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP
);

-- ============================================
-- notices（お知らせ）
-- ============================================
CREATE TABLE notices (
  id INT AUTO_INCREMENT PRIMARY KEY,
  admin_id INT NOT NULL,
  title VARCHAR(255) NOT NULL,
  content TEXT NOT NULL,
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
  updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  FOREIGN KEY (admin_id) REFERENCES admin_users(id)
);

-- ============================================
-- seat_status（空席状況）
-- ============================================
CREATE TABLE seat_status (
  id INT AUTO_INCREMENT PRIMARY KEY,
  date DATE NOT NULL,
  available_seats INT NOT NULL,
  comment TEXT,
  updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

-- ============================================
-- reservation_settings（予約可能日設定）
-- ============================================
CREATE TABLE reservation_settings (
  id INT AUTO_INCREMENT PRIMARY KEY,
  date DATE NOT NULL,
  is_available BOOLEAN DEFAULT TRUE,
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP
);
