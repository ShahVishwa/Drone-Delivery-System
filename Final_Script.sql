SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='TRADITIONAL,ALLOW_INVALID_DATES';

-- -----------------------------------------------------
-- Schema Delivery_System
-- -----------------------------------------------------
DROP SCHEMA IF EXISTS `Delivery_System` ;
CREATE SCHEMA IF NOT EXISTS `Delivery_System` DEFAULT CHARACTER SET utf8 COLLATE utf8_general_ci ;
USE `Delivery_System` ;

-- -----------------------------------------------------
-- Table `Delivery_System`.`Customer`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Delivery_System`.`Customer` ;

CREATE TABLE IF NOT EXISTS `Delivery_System`.`Customer` (
  `Cust_ID` INT NOT NULL,
  `Cust_Name` VARCHAR(45) NULL,
  `Email_ID` VARCHAR(45) NULL,
  PRIMARY KEY (`Cust_ID`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Delivery_System`.`Zip_Code`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Delivery_System`.`Zip_Code` ;

CREATE TABLE IF NOT EXISTS `Delivery_System`.`Zip_Code` (
  `Zip_Code` INT NOT NULL,
  `City` VARCHAR(45) NULL,
  `State` VARCHAR(45) NULL,
  `Longitude` VARCHAR(45) NULL,
  `Latitude` VARCHAR(45) NULL,
  PRIMARY KEY (`Zip_Code`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Delivery_System`.`CustShipping_Address`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Delivery_System`.`CustShipping_Address` ;

CREATE TABLE IF NOT EXISTS `Delivery_System`.`CustShipping_Address` (
  `ShippingAddress_ID` INT NOT NULL,
  `Shipping_Name` VARCHAR(45) NULL,
  `Street_1` VARCHAR(45) NULL,
  `Zip_Code` INT NOT NULL,
  PRIMARY KEY (`ShippingAddress_ID`),
  INDEX `fk_CustShipping_Address_Zip_Code1_idx` (`Zip_Code` ASC),
  CONSTRAINT `fk_CustShipping_Address_Zip_Code1`
    FOREIGN KEY (`Zip_Code`)
    REFERENCES `Delivery_System`.`Zip_Code` (`Zip_Code`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Delivery_System`.`Vendor`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Delivery_System`.`Vendor` ;

CREATE TABLE IF NOT EXISTS `Delivery_System`.`Vendor` (
  `Vendor_ID` INT NOT NULL,
  `Vendor_Name` VARCHAR(45) NULL,
  PRIMARY KEY (`Vendor_ID`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Delivery_System`.`Product_Model`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Delivery_System`.`Product_Model` ;

CREATE TABLE IF NOT EXISTS `Delivery_System`.`Product_Model` (
  `Model_Number` INT NOT NULL,
  `Prod_Model_Name` VARCHAR(45) NULL,
  `Total_Quantity` VARCHAR(45) NULL,
  `Vendor_ID` INT NOT NULL,
  PRIMARY KEY (`Model_Number`),
  INDEX `fk_Product_Model_Vendor1_idx` (`Vendor_ID` ASC),
  CONSTRAINT `fk_Product_Model_Vendor1`
    FOREIGN KEY (`Vendor_ID`)
    REFERENCES `Delivery_System`.`Vendor` (`Vendor_ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Delivery_System`.`Product_Unit`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Delivery_System`.`Product_Unit` ;

CREATE TABLE IF NOT EXISTS `Delivery_System`.`Product_Unit` (
  `Serial_No` INT NOT NULL,
  `Product_UnitPrice` FLOAT NULL,
  `Color` VARCHAR(45) NULL,
  `Size` VARCHAR(45) NULL,
  `Model_Number` INT NOT NULL,
  PRIMARY KEY (`Serial_No`),
  INDEX `fk_Product_Brand1_idx` (`Model_Number` ASC),
  CONSTRAINT `fk_Product_Brand1`
    FOREIGN KEY (`Model_Number`)
    REFERENCES `Delivery_System`.`Product_Model` (`Model_Number`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Delivery_System`.`Department`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Delivery_System`.`Department` ;

CREATE TABLE IF NOT EXISTS `Delivery_System`.`Department` (
  `Department_ID` INT NOT NULL,
  `Department_Name` VARCHAR(100) NULL,
  PRIMARY KEY (`Department_ID`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Delivery_System`.`Category`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Delivery_System`.`Category` ;

CREATE TABLE IF NOT EXISTS `Delivery_System`.`Category` (
  `Category_ID` INT NOT NULL,
  `Category_Name` VARCHAR(45) NULL,
  `Department_ID` INT NOT NULL,
  PRIMARY KEY (`Category_ID`),
  INDEX `fk_Category_Department1_idx` (`Department_ID` ASC),
  CONSTRAINT `fk_Category_Department1`
    FOREIGN KEY (`Department_ID`)
    REFERENCES `Delivery_System`.`Department` (`Department_ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Delivery_System`.`Warehouse`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Delivery_System`.`Warehouse` ;

CREATE TABLE IF NOT EXISTS `Delivery_System`.`Warehouse` (
  `warehouse_ID` INT NOT NULL,
  `Street_1` VARCHAR(100) NULL,
  `Zip_Code` INT NOT NULL,
  `Vendor_ID` INT NOT NULL,
  PRIMARY KEY (`warehouse_ID`),
  INDEX `fk_Warehouse_Zip_Code1_idx` (`Zip_Code` ASC),
  INDEX `fk_Warehouse_Vendor1_idx` (`Vendor_ID` ASC),
  CONSTRAINT `fk_Warehouse_Zip_Code1`
    FOREIGN KEY (`Zip_Code`)
    REFERENCES `Delivery_System`.`Zip_Code` (`Zip_Code`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Warehouse_Vendor1`
    FOREIGN KEY (`Vendor_ID`)
    REFERENCES `Delivery_System`.`Vendor` (`Vendor_ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Delivery_System`.`Drone_Type`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Delivery_System`.`Drone_Type` ;

CREATE TABLE IF NOT EXISTS `Delivery_System`.`Drone_Type` (
  `Drone_Type_ID` VARCHAR(10) NOT NULL,
  `Drone_Weight` INT NULL,
  `Drone_Capacity` INT NULL,
  `Drone_Units` INT NULL,
  `Battery_Desc` INT NULL,
  PRIMARY KEY (`Drone_Type_ID`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Delivery_System`.`Drone_Details`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Delivery_System`.`Drone_Details` ;

CREATE TABLE IF NOT EXISTS `Delivery_System`.`Drone_Details` (
  `Drone_ID` INT NOT NULL,
  `Drone_Status` VARCHAR(40) NULL,
  `warehouse_ID` INT NOT NULL,
  `Drone_Type_ID` VARCHAR(10) NOT NULL,
  PRIMARY KEY (`Drone_ID`),
  INDEX `fk_Drone_Warehouse1_idx` (`warehouse_ID` ASC),
  INDEX `fk_Drone_Details_Drone_Type1_idx` (`Drone_Type_ID` ASC),
  CONSTRAINT `fk_Drone_Warehouse1`
    FOREIGN KEY (`warehouse_ID`)
    REFERENCES `Delivery_System`.`Warehouse` (`warehouse_ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Drone_Details_Drone_Type1`
    FOREIGN KEY (`Drone_Type_ID`)
    REFERENCES `Delivery_System`.`Drone_Type` (`Drone_Type_ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Delivery_System`.`Order_Item`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Delivery_System`.`Order_Item` ;

CREATE TABLE IF NOT EXISTS `Delivery_System`.`Order_Item` (
  `OrderItem_ID` INT NOT NULL,
  `OrderItem_Status` VARCHAR(45) NULL,
  `Order_Date` DATE NULL,
  `Package_weight` FLOAT NOT NULL,
  `Serial_No` INT NOT NULL,
  `Drone_ID` INT NOT NULL,
  `Customer_Cust_ID` INT NOT NULL,
  PRIMARY KEY (`OrderItem_ID`),
  INDEX `fk_Order_Item_Product1_idx` (`Serial_No` ASC),
  INDEX `fk_Order_Item_Drone1_idx` (`Drone_ID` ASC),
  INDEX `fk_Order_Item_Customer1_idx` (`Customer_Cust_ID` ASC),
  CONSTRAINT `fk_Order_Item_Product1`
    FOREIGN KEY (`Serial_No`)
    REFERENCES `Delivery_System`.`Product_Unit` (`Serial_No`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Order_Item_Drone1`
    FOREIGN KEY (`Drone_ID`)
    REFERENCES `Delivery_System`.`Drone_Details` (`Drone_ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Order_Item_Customer1`
    FOREIGN KEY (`Customer_Cust_ID`)
    REFERENCES `Delivery_System`.`Customer` (`Cust_ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Delivery_System`.`Phone`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Delivery_System`.`Phone` ;

CREATE TABLE IF NOT EXISTS `Delivery_System`.`Phone` (
  `Phone_ID` INT NOT NULL,
  `Number` VARCHAR(45) NULL,
  `Cust_ID` INT NOT NULL,
  PRIMARY KEY (`Phone_ID`),
  INDEX `fk_Phone_Customer1_idx` (`Cust_ID` ASC),
  CONSTRAINT `fk_Phone_Customer1`
    FOREIGN KEY (`Cust_ID`)
    REFERENCES `Delivery_System`.`Customer` (`Cust_ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Delivery_System`.`Precipitation`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Delivery_System`.`Precipitation` ;

CREATE TABLE IF NOT EXISTS `Delivery_System`.`Precipitation` (
  `Precipitation_ID` INT NOT NULL,
  `Description` VARCHAR(150) NULL,
  PRIMARY KEY (`Precipitation_ID`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Delivery_System`.`Direction`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Delivery_System`.`Direction` ;

CREATE TABLE IF NOT EXISTS `Delivery_System`.`Direction` (
  `Direction_ID` INT NOT NULL,
  `Description` VARCHAR(150) NULL,
  PRIMARY KEY (`Direction_ID`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Delivery_System`.`Weather`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Delivery_System`.`Weather` ;

CREATE TABLE IF NOT EXISTS `Delivery_System`.`Weather` (
  `Weather_ID` DATETIME NOT NULL,
  `Temperature` INT NULL,
  `Humidity` VARCHAR(45) NULL,
  `Wind_Speed` FLOAT NULL,
  `Precipitation_ID` INT NOT NULL,
  `Direction_ID` INT NOT NULL,
  `Zip_Code` INT NOT NULL,
  PRIMARY KEY (`Weather_ID`),
  INDEX `fk_Weather_Precipitation1_idx` (`Precipitation_ID` ASC),
  INDEX `fk_Weather_Direction1_idx` (`Direction_ID` ASC),
  INDEX `fk_Weather_Zip_Code1_idx` (`Zip_Code` ASC),
  CONSTRAINT `fk_Weather_Precipitation1`
    FOREIGN KEY (`Precipitation_ID`)
    REFERENCES `Delivery_System`.`Precipitation` (`Precipitation_ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Weather_Direction1`
    FOREIGN KEY (`Direction_ID`)
    REFERENCES `Delivery_System`.`Direction` (`Direction_ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Weather_Zip_Code1`
    FOREIGN KEY (`Zip_Code`)
    REFERENCES `Delivery_System`.`Zip_Code` (`Zip_Code`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Delivery_System`.`Payment_Method`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Delivery_System`.`Payment_Method` ;

CREATE TABLE IF NOT EXISTS `Delivery_System`.`Payment_Method` (
  `Method_ID` INT NOT NULL,
  `Type` VARCHAR(45) NULL,
  PRIMARY KEY (`Method_ID`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Delivery_System`.`Details`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Delivery_System`.`Details` ;

CREATE TABLE IF NOT EXISTS `Delivery_System`.`Details` (
  `Method_ID` INT NOT NULL,
  `Cust_ID` INT NOT NULL,
  `Detail_ID` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`Detail_ID`),
  INDEX `fk_Payment_Method_has_Customer_Customer1_idx` (`Cust_ID` ASC),
  INDEX `fk_Payment_Method_has_Customer_Payment_Method1_idx` (`Method_ID` ASC),
  CONSTRAINT `fk_Payment_Method_has_Customer_Payment_Method1`
    FOREIGN KEY (`Method_ID`)
    REFERENCES `Delivery_System`.`Payment_Method` (`Method_ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Payment_Method_has_Customer_Customer1`
    FOREIGN KEY (`Cust_ID`)
    REFERENCES `Delivery_System`.`Customer` (`Cust_ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Delivery_System`.`Invoice`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Delivery_System`.`Invoice` ;

CREATE TABLE IF NOT EXISTS `Delivery_System`.`Invoice` (
  `Invoice_ID` INT NOT NULL,
  `Amount` VARCHAR(45) NULL,
  `Invoice_Status` VARCHAR(45) NULL,
  `Paid_Date` DATE NULL,
  `Detail_ID` VARCHAR(45) NOT NULL,
  `OrderItem_ID` INT NOT NULL,
  PRIMARY KEY (`Invoice_ID`),
  INDEX `fk_Invoice_Detail1_idx` (`Detail_ID` ASC),
  INDEX `fk_Invoice_Order_Item1_idx` (`OrderItem_ID` ASC),
  CONSTRAINT `fk_Invoice_Detail1`
    FOREIGN KEY (`Detail_ID`)
    REFERENCES `Delivery_System`.`Details` (`Detail_ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Invoice_Order_Item1`
    FOREIGN KEY (`OrderItem_ID`)
    REFERENCES `Delivery_System`.`Order_Item` (`OrderItem_ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Delivery_System`.`Card_Details`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Delivery_System`.`Card_Details` ;

CREATE TABLE IF NOT EXISTS `Delivery_System`.`Card_Details` (
  `Card_No` VARCHAR(16) NOT NULL,
  `Card_Name` VARCHAR(100) NULL,
  `CVV` INT NULL,
  `Street_1` VARCHAR(200) NULL,
  `City` VARCHAR(100) NULL,
  `State` VARCHAR(100) NULL,
  `Zip` INT NULL,
  `Method_ID` INT NOT NULL,
  INDEX `fk_Card_Details_Payment_Method1_idx` (`Method_ID` ASC),
  PRIMARY KEY (`Method_ID`),
  CONSTRAINT `fk_Card_Details_Payment_Method1`
    FOREIGN KEY (`Method_ID`)
    REFERENCES `Delivery_System`.`Payment_Method` (`Method_ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Delivery_System`.`Online_Transaction`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Delivery_System`.`Online_Transaction` ;

CREATE TABLE IF NOT EXISTS `Delivery_System`.`Online_Transaction` (
  `Email_ID` VARCHAR(45) NULL,
  `Password` VARCHAR(45) NULL,
  `Method_ID` INT NOT NULL,
  INDEX `fk_Online_Transaction_Payment_Method1_idx` (`Method_ID` ASC),
  PRIMARY KEY (`Method_ID`),
  CONSTRAINT `fk_Online_Transaction_Payment_Method1`
    FOREIGN KEY (`Method_ID`)
    REFERENCES `Delivery_System`.`Payment_Method` (`Method_ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Delivery_System`.`Gift_Card`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Delivery_System`.`Gift_Card` ;

CREATE TABLE IF NOT EXISTS `Delivery_System`.`Gift_Card` (
  `Card_Num` VARCHAR(15) NULL,
  `Exp_Date` VARCHAR(45) NULL,
  `Method_ID` INT NOT NULL,
  INDEX `fk_Gift_Card_Payment_Method1_idx` (`Method_ID` ASC),
  PRIMARY KEY (`Method_ID`),
  CONSTRAINT `fk_Gift_Card_Payment_Method1`
    FOREIGN KEY (`Method_ID`)
    REFERENCES `Delivery_System`.`Payment_Method` (`Method_ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Delivery_System`.`Department_has_Vendor`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Delivery_System`.`Department_has_Vendor` ;

CREATE TABLE IF NOT EXISTS `Delivery_System`.`Department_has_Vendor` (
  `Department_ID` INT NOT NULL,
  `Vendor_ID` INT NOT NULL,
  PRIMARY KEY (`Department_ID`, `Vendor_ID`),
  INDEX `fk_Department_has_Vendor_Vendor1_idx` (`Vendor_ID` ASC),
  INDEX `fk_Department_has_Vendor_Department1_idx` (`Department_ID` ASC),
  CONSTRAINT `fk_Department_has_Vendor_Department1`
    FOREIGN KEY (`Department_ID`)
    REFERENCES `Delivery_System`.`Department` (`Department_ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Department_has_Vendor_Vendor1`
    FOREIGN KEY (`Vendor_ID`)
    REFERENCES `Delivery_System`.`Vendor` (`Vendor_ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Delivery_System`.`Feedback`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Delivery_System`.`Feedback` ;

CREATE TABLE IF NOT EXISTS `Delivery_System`.`Feedback` (
  `Feedback_ID` INT NOT NULL,
  `Product_Rating` FLOAT NULL,
  `Feedback_Description` VARCHAR(200) NULL,
  `Date` DATE NULL,
  `Cust_ID` INT NOT NULL,
  `Model_Number` INT NOT NULL,
  PRIMARY KEY (`Feedback_ID`),
  INDEX `fk_Feedback_Customer1_idx` (`Cust_ID` ASC),
  INDEX `fk_Feedback_Product_Model1_idx` (`Model_Number` ASC),
  CONSTRAINT `fk_Feedback_Customer1`
    FOREIGN KEY (`Cust_ID`)
    REFERENCES `Delivery_System`.`Customer` (`Cust_ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Feedback_Product_Model1`
    FOREIGN KEY (`Model_Number`)
    REFERENCES `Delivery_System`.`Product_Model` (`Model_Number`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Delivery_System`.`Customer_has_CustShipping_Address`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Delivery_System`.`Customer_has_CustShipping_Address` ;

CREATE TABLE IF NOT EXISTS `Delivery_System`.`Customer_has_CustShipping_Address` (
  `Cust_ID` INT NOT NULL,
  `ShippingAddress_ID` INT NOT NULL,
  PRIMARY KEY (`Cust_ID`, `ShippingAddress_ID`),
  INDEX `fk_Customer_has_CustShipping_Address_CustShipping_Address1_idx` (`ShippingAddress_ID` ASC),
  INDEX `fk_Customer_has_CustShipping_Address_Customer1_idx` (`Cust_ID` ASC),
  CONSTRAINT `fk_Customer_has_CustShipping_Address_Customer1`
    FOREIGN KEY (`Cust_ID`)
    REFERENCES `Delivery_System`.`Customer` (`Cust_ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Customer_has_CustShipping_Address_CustShipping_Address1`
    FOREIGN KEY (`ShippingAddress_ID`)
    REFERENCES `Delivery_System`.`CustShipping_Address` (`ShippingAddress_ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Delivery_System`.`Drone_Delivery`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Delivery_System`.`Drone_Delivery` ;

CREATE TABLE IF NOT EXISTS `Delivery_System`.`Drone_Delivery` (
  `Delivery_ID` INT NOT NULL,
  `Delivery_Date` DATE NULL,
  `Delivery_Time` TIME NULL,
  `Drone_ID` INT NOT NULL,
  `ShippingAddress_ID` INT NOT NULL,
  `OrderItem_ID` INT NOT NULL,
  PRIMARY KEY (`Delivery_ID`),
  INDEX `fk_Drone_Delivery_Drone1_idx` (`Drone_ID` ASC),
  INDEX `fk_Drone_Delivery_CustShipping_Address1_idx` (`ShippingAddress_ID` ASC),
  INDEX `fk_Drone_Delivery_Order_Item1_idx` (`OrderItem_ID` ASC),
  CONSTRAINT `fk_Drone_Delivery_Drone1`
    FOREIGN KEY (`Drone_ID`)
    REFERENCES `Delivery_System`.`Drone_Details` (`Drone_ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Drone_Delivery_CustShipping_Address1`
    FOREIGN KEY (`ShippingAddress_ID`)
    REFERENCES `Delivery_System`.`CustShipping_Address` (`ShippingAddress_ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Drone_Delivery_Order_Item1`
    FOREIGN KEY (`OrderItem_ID`)
    REFERENCES `Delivery_System`.`Order_Item` (`OrderItem_ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Delivery_System`.`Warehouse_has_Product_Model`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Delivery_System`.`Warehouse_has_Product_Model` ;

CREATE TABLE IF NOT EXISTS `Delivery_System`.`Warehouse_has_Product_Model` (
  `warehouse_ID` INT NOT NULL,
  `Model_Number` INT NOT NULL,
  PRIMARY KEY (`warehouse_ID`, `Model_Number`),
  INDEX `fk_Warehouse_has_Product_Model_Product_Model1_idx` (`Model_Number` ASC),
  INDEX `fk_Warehouse_has_Product_Model_Warehouse1_idx` (`warehouse_ID` ASC),
  CONSTRAINT `fk_Warehouse_has_Product_Model_Warehouse1`
    FOREIGN KEY (`warehouse_ID`)
    REFERENCES `Delivery_System`.`Warehouse` (`warehouse_ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Warehouse_has_Product_Model_Product_Model1`
    FOREIGN KEY (`Model_Number`)
    REFERENCES `Delivery_System`.`Product_Model` (`Model_Number`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;

-- -----------------------------------------------------
-- Data for table `Delivery_System`.`Customer`
-- -----------------------------------------------------
START TRANSACTION;
USE `Delivery_System`;
INSERT INTO `Delivery_System`.`Customer` (`Cust_ID`, `Cust_Name`, `Email_ID`) VALUES (1, 'Avye Pierce', 'Pierce.Avye@gmail.com');
INSERT INTO `Delivery_System`.`Customer` (`Cust_ID`, `Cust_Name`, `Email_ID`) VALUES (2, 'Sydney Camacho', 'Camacho.Sydney@gmail.com');
INSERT INTO `Delivery_System`.`Customer` (`Cust_ID`, `Cust_Name`, `Email_ID`) VALUES (3, 'Mohammad Bonner', 'Bonner.Mohammad@gmail.com');
INSERT INTO `Delivery_System`.`Customer` (`Cust_ID`, `Cust_Name`, `Email_ID`) VALUES (4, 'Chastity Moody', 'Moody.Chastity@gmail.com');
INSERT INTO `Delivery_System`.`Customer` (`Cust_ID`, `Cust_Name`, `Email_ID`) VALUES (5, 'Iliana Herman', 'Herman.Iliana@gmail.com');
INSERT INTO `Delivery_System`.`Customer` (`Cust_ID`, `Cust_Name`, `Email_ID`) VALUES (6, 'Indigo Hester', 'Hester.Indigo@gmail.com');
INSERT INTO `Delivery_System`.`Customer` (`Cust_ID`, `Cust_Name`, `Email_ID`) VALUES (7, 'Jenette Gardner', 'Gardner.Jenette@gmail.com');
INSERT INTO `Delivery_System`.`Customer` (`Cust_ID`, `Cust_Name`, `Email_ID`) VALUES (8, 'Nevada Charles', 'Charles.Nevada@gmail.com');
INSERT INTO `Delivery_System`.`Customer` (`Cust_ID`, `Cust_Name`, `Email_ID`) VALUES (9, 'Yolanda Booker', 'Booker.Yolanda@gmail.com');
INSERT INTO `Delivery_System`.`Customer` (`Cust_ID`, `Cust_Name`, `Email_ID`) VALUES (10, 'Xanthus Church', 'Church.Xanthus@gmail.com');
INSERT INTO `Delivery_System`.`Customer` (`Cust_ID`, `Cust_Name`, `Email_ID`) VALUES (11, 'Beverly Dyer', 'Dyer.Beverly@gmail.com');
INSERT INTO `Delivery_System`.`Customer` (`Cust_ID`, `Cust_Name`, `Email_ID`) VALUES (12, 'Leslie Britt', 'Britt.Leslie@gmail.com');
INSERT INTO `Delivery_System`.`Customer` (`Cust_ID`, `Cust_Name`, `Email_ID`) VALUES (13, 'Josiah Day', 'Day.Josiah@gmail.com');
INSERT INTO `Delivery_System`.`Customer` (`Cust_ID`, `Cust_Name`, `Email_ID`) VALUES (14, 'Bevis Lambert', 'Lambert.Bevis@gmail.com');
INSERT INTO `Delivery_System`.`Customer` (`Cust_ID`, `Cust_Name`, `Email_ID`) VALUES (15, 'Kaitlin Valentine', 'Valentine.Kaitlin@gmail.com');
INSERT INTO `Delivery_System`.`Customer` (`Cust_ID`, `Cust_Name`, `Email_ID`) VALUES (16, 'Jade Ellison', 'Ellison.Jade@gmail.com');
INSERT INTO `Delivery_System`.`Customer` (`Cust_ID`, `Cust_Name`, `Email_ID`) VALUES (17, 'Abra Turner', 'Turner.Abra@gmail.com');
INSERT INTO `Delivery_System`.`Customer` (`Cust_ID`, `Cust_Name`, `Email_ID`) VALUES (18, 'Maris Mckinney', 'Mckinney.Maris@gmail.com');
INSERT INTO `Delivery_System`.`Customer` (`Cust_ID`, `Cust_Name`, `Email_ID`) VALUES (19, 'Dacey English', 'English.Dacey@gmail.com');
INSERT INTO `Delivery_System`.`Customer` (`Cust_ID`, `Cust_Name`, `Email_ID`) VALUES (20, 'Nash Lane', 'Lane.Nash@gmail.com');
INSERT INTO `Delivery_System`.`Customer` (`Cust_ID`, `Cust_Name`, `Email_ID`) VALUES (21, 'Olga Mcintosh', 'Mcintosh.Olga@gmail.com');
INSERT INTO `Delivery_System`.`Customer` (`Cust_ID`, `Cust_Name`, `Email_ID`) VALUES (22, 'Leigh Garza', 'Garza.Leigh@gmail.com');
INSERT INTO `Delivery_System`.`Customer` (`Cust_ID`, `Cust_Name`, `Email_ID`) VALUES (23, 'Yvonne Castaneda', 'Castaneda.Yvonne@gmail.com');
INSERT INTO `Delivery_System`.`Customer` (`Cust_ID`, `Cust_Name`, `Email_ID`) VALUES (24, 'Samantha Calderon', 'Calderon.Samantha@gmail.com');
INSERT INTO `Delivery_System`.`Customer` (`Cust_ID`, `Cust_Name`, `Email_ID`) VALUES (25, 'Carter Scott', 'Scott.Carter@gmail.com');
INSERT INTO `Delivery_System`.`Customer` (`Cust_ID`, `Cust_Name`, `Email_ID`) VALUES (26, 'Leigh Brennan', 'Brennan.Leigh@gmail.com');
INSERT INTO `Delivery_System`.`Customer` (`Cust_ID`, `Cust_Name`, `Email_ID`) VALUES (27, 'Davis Valenzuela', 'Valenzuela.Davis@gmail.com');
INSERT INTO `Delivery_System`.`Customer` (`Cust_ID`, `Cust_Name`, `Email_ID`) VALUES (28, 'Kameko Shelton', 'Shelton.Kameko@gmail.com');
INSERT INTO `Delivery_System`.`Customer` (`Cust_ID`, `Cust_Name`, `Email_ID`) VALUES (29, 'Cheyenne Aguirre', 'Aguirre.Cheyenne@gmail.com');
INSERT INTO `Delivery_System`.`Customer` (`Cust_ID`, `Cust_Name`, `Email_ID`) VALUES (30, 'Diana Stark', 'Stark.Diana@gmail.com');
INSERT INTO `Delivery_System`.`Customer` (`Cust_ID`, `Cust_Name`, `Email_ID`) VALUES (31, 'Micah Guthrie', 'Guthrie.Micah@gmail.com');
INSERT INTO `Delivery_System`.`Customer` (`Cust_ID`, `Cust_Name`, `Email_ID`) VALUES (32, 'Haley Clay', 'Clay.Haley@gmail.com');
INSERT INTO `Delivery_System`.`Customer` (`Cust_ID`, `Cust_Name`, `Email_ID`) VALUES (33, 'Tyrone Boyle', 'Boyle.Tyrone@gmail.com');
INSERT INTO `Delivery_System`.`Customer` (`Cust_ID`, `Cust_Name`, `Email_ID`) VALUES (34, 'Jack Stephens', 'Stephens.Jack@gmail.com');
INSERT INTO `Delivery_System`.`Customer` (`Cust_ID`, `Cust_Name`, `Email_ID`) VALUES (35, 'Gay Charles', 'Charles.Gay@gmail.com');
INSERT INTO `Delivery_System`.`Customer` (`Cust_ID`, `Cust_Name`, `Email_ID`) VALUES (36, 'Clare Mcmahon', 'Mcmahon.Clare@gmail.com');
INSERT INTO `Delivery_System`.`Customer` (`Cust_ID`, `Cust_Name`, `Email_ID`) VALUES (37, 'Christen Medina', 'Medina.Christen@gmail.com');
INSERT INTO `Delivery_System`.`Customer` (`Cust_ID`, `Cust_Name`, `Email_ID`) VALUES (38, 'Elvis Mayer', 'Mayer.Elvis@gmail.com');
INSERT INTO `Delivery_System`.`Customer` (`Cust_ID`, `Cust_Name`, `Email_ID`) VALUES (39, 'Amaya Morin', 'Morin.Amaya@gmail.com');
INSERT INTO `Delivery_System`.`Customer` (`Cust_ID`, `Cust_Name`, `Email_ID`) VALUES (40, 'Kalia Bray', 'Bray.Kalia@gmail.com');
INSERT INTO `Delivery_System`.`Customer` (`Cust_ID`, `Cust_Name`, `Email_ID`) VALUES (41, 'Asher Buckley', 'Buckley.Asher@gmail.com');
INSERT INTO `Delivery_System`.`Customer` (`Cust_ID`, `Cust_Name`, `Email_ID`) VALUES (42, 'Vance Cohen', 'Cohen.Vance@gmail.com');
INSERT INTO `Delivery_System`.`Customer` (`Cust_ID`, `Cust_Name`, `Email_ID`) VALUES (43, 'Winter West', 'West.Winter@gmail.com');
INSERT INTO `Delivery_System`.`Customer` (`Cust_ID`, `Cust_Name`, `Email_ID`) VALUES (44, 'Bell Jenkins', 'Jenkins.Bell@gmail.com');
INSERT INTO `Delivery_System`.`Customer` (`Cust_ID`, `Cust_Name`, `Email_ID`) VALUES (45, 'Unity Gomez', 'Gomez.Unity@gmail.com');
INSERT INTO `Delivery_System`.`Customer` (`Cust_ID`, `Cust_Name`, `Email_ID`) VALUES (46, 'Shad Hubbard', 'Hubbard.Shad@gmail.com');
INSERT INTO `Delivery_System`.`Customer` (`Cust_ID`, `Cust_Name`, `Email_ID`) VALUES (47, 'Elijah Hays', 'Hays.Elijah@gmail.com');
INSERT INTO `Delivery_System`.`Customer` (`Cust_ID`, `Cust_Name`, `Email_ID`) VALUES (48, 'Hashim Perkins', 'Perkins.Hashim@gmail.com');
INSERT INTO `Delivery_System`.`Customer` (`Cust_ID`, `Cust_Name`, `Email_ID`) VALUES (49, 'Armando Bartlett', 'Bartlett.Armando@gmail.com');
INSERT INTO `Delivery_System`.`Customer` (`Cust_ID`, `Cust_Name`, `Email_ID`) VALUES (50, 'Dillon Bell', 'Bell.Dillon@gmail.com');
INSERT INTO `Delivery_System`.`Customer` (`Cust_ID`, `Cust_Name`, `Email_ID`) VALUES (51, 'Justin David', 'David.Justin@gmail.com');
INSERT INTO `Delivery_System`.`Customer` (`Cust_ID`, `Cust_Name`, `Email_ID`) VALUES (52, 'Reese Grant', 'Grant.Reese@gmail.com');
INSERT INTO `Delivery_System`.`Customer` (`Cust_ID`, `Cust_Name`, `Email_ID`) VALUES (53, 'Nicole Irwin', 'Irwin.Nicole@gmail.com');
INSERT INTO `Delivery_System`.`Customer` (`Cust_ID`, `Cust_Name`, `Email_ID`) VALUES (54, 'Halla Gillespie', 'Gillespie.Halla@gmail.com');
INSERT INTO `Delivery_System`.`Customer` (`Cust_ID`, `Cust_Name`, `Email_ID`) VALUES (55, 'Martha Zimmerman', 'Zimmerman.Martha@gmail.com');
INSERT INTO `Delivery_System`.`Customer` (`Cust_ID`, `Cust_Name`, `Email_ID`) VALUES (56, 'Alexis Orr', 'Orr.Alexis@gmail.com');
INSERT INTO `Delivery_System`.`Customer` (`Cust_ID`, `Cust_Name`, `Email_ID`) VALUES (57, 'Madeson Pena', 'Pena.Madeson@gmail.com');
INSERT INTO `Delivery_System`.`Customer` (`Cust_ID`, `Cust_Name`, `Email_ID`) VALUES (58, 'Lois Velez', 'Velez.Lois@gmail.com');
INSERT INTO `Delivery_System`.`Customer` (`Cust_ID`, `Cust_Name`, `Email_ID`) VALUES (59, 'Adam Dunlap', 'Dunlap.Adam@gmail.com');
INSERT INTO `Delivery_System`.`Customer` (`Cust_ID`, `Cust_Name`, `Email_ID`) VALUES (60, 'Hayes Griffith', 'Griffith.Hayes@gmail.com');
INSERT INTO `Delivery_System`.`Customer` (`Cust_ID`, `Cust_Name`, `Email_ID`) VALUES (61, 'Nadine Flynn', 'Flynn.Nadine@gmail.com');
INSERT INTO `Delivery_System`.`Customer` (`Cust_ID`, `Cust_Name`, `Email_ID`) VALUES (62, 'Lucas Roman', 'Roman.Lucas@gmail.com');
INSERT INTO `Delivery_System`.`Customer` (`Cust_ID`, `Cust_Name`, `Email_ID`) VALUES (63, 'Rafael Estrada', 'Estrada.Rafael@gmail.com');
INSERT INTO `Delivery_System`.`Customer` (`Cust_ID`, `Cust_Name`, `Email_ID`) VALUES (64, 'Francesca Patterson', 'Patterson.Francesca@gmail.com');
INSERT INTO `Delivery_System`.`Customer` (`Cust_ID`, `Cust_Name`, `Email_ID`) VALUES (65, 'Tanner Boyle', 'Boyle.Tanner@gmail.com');
INSERT INTO `Delivery_System`.`Customer` (`Cust_ID`, `Cust_Name`, `Email_ID`) VALUES (66, 'Shad Boyle', 'Boyle.Shad@gmail.com');
INSERT INTO `Delivery_System`.`Customer` (`Cust_ID`, `Cust_Name`, `Email_ID`) VALUES (67, 'Caesar Hammond', 'Hammond.Caesar@gmail.com');
INSERT INTO `Delivery_System`.`Customer` (`Cust_ID`, `Cust_Name`, `Email_ID`) VALUES (68, 'Lilah Pratt', 'Pratt.Lilah@gmail.com');
INSERT INTO `Delivery_System`.`Customer` (`Cust_ID`, `Cust_Name`, `Email_ID`) VALUES (69, 'Oprah Norton', 'Norton.Oprah@gmail.com');
INSERT INTO `Delivery_System`.`Customer` (`Cust_ID`, `Cust_Name`, `Email_ID`) VALUES (70, 'Maggy Walton', 'Walton.Maggy@gmail.com');
INSERT INTO `Delivery_System`.`Customer` (`Cust_ID`, `Cust_Name`, `Email_ID`) VALUES (71, 'Xandra Mccormick', 'Mccormick.Xandra@gmail.com');
INSERT INTO `Delivery_System`.`Customer` (`Cust_ID`, `Cust_Name`, `Email_ID`) VALUES (72, 'Malik Salas', 'Salas.Malik@gmail.com');
INSERT INTO `Delivery_System`.`Customer` (`Cust_ID`, `Cust_Name`, `Email_ID`) VALUES (73, 'Aubrey Mccarthy', 'Mccarthy.Aubrey@gmail.com');
INSERT INTO `Delivery_System`.`Customer` (`Cust_ID`, `Cust_Name`, `Email_ID`) VALUES (74, 'Stella Gross', 'Gross.Stella@gmail.com');
INSERT INTO `Delivery_System`.`Customer` (`Cust_ID`, `Cust_Name`, `Email_ID`) VALUES (75, 'Ferdinand Rutledge', 'Rutledge.Ferdinand@gmail.com');
INSERT INTO `Delivery_System`.`Customer` (`Cust_ID`, `Cust_Name`, `Email_ID`) VALUES (76, 'Winter Bowman', 'Bowman.Winter@gmail.com');
INSERT INTO `Delivery_System`.`Customer` (`Cust_ID`, `Cust_Name`, `Email_ID`) VALUES (77, 'Cheyenne Baxter', 'Baxter.Cheyenne@gmail.com');
INSERT INTO `Delivery_System`.`Customer` (`Cust_ID`, `Cust_Name`, `Email_ID`) VALUES (78, 'Erasmus Best', 'Best.Erasmus@gmail.com');
INSERT INTO `Delivery_System`.`Customer` (`Cust_ID`, `Cust_Name`, `Email_ID`) VALUES (79, 'Moana Holmes', 'Holmes.Moana@gmail.com');
INSERT INTO `Delivery_System`.`Customer` (`Cust_ID`, `Cust_Name`, `Email_ID`) VALUES (80, 'Nell Wolfe', 'Wolfe.Nell@gmail.com');
INSERT INTO `Delivery_System`.`Customer` (`Cust_ID`, `Cust_Name`, `Email_ID`) VALUES (81, 'Winter Wilson', 'Wilson.Winter@gmail.com');
INSERT INTO `Delivery_System`.`Customer` (`Cust_ID`, `Cust_Name`, `Email_ID`) VALUES (82, 'Leslie Torres', 'Torres.Leslie@gmail.com');
INSERT INTO `Delivery_System`.`Customer` (`Cust_ID`, `Cust_Name`, `Email_ID`) VALUES (83, 'Richard Ross', 'Ross.Richard@gmail.com');
INSERT INTO `Delivery_System`.`Customer` (`Cust_ID`, `Cust_Name`, `Email_ID`) VALUES (84, 'Oscar Wolf', 'Wolf.Oscar@gmail.com');
INSERT INTO `Delivery_System`.`Customer` (`Cust_ID`, `Cust_Name`, `Email_ID`) VALUES (85, 'Igor Best', 'Best.Igor@gmail.com');
INSERT INTO `Delivery_System`.`Customer` (`Cust_ID`, `Cust_Name`, `Email_ID`) VALUES (86, 'Chandler Mcgowan', 'Mcgowan.Chandler@gmail.com');
INSERT INTO `Delivery_System`.`Customer` (`Cust_ID`, `Cust_Name`, `Email_ID`) VALUES (87, 'Amanda Farmer', 'Farmer.Amanda@gmail.com');
INSERT INTO `Delivery_System`.`Customer` (`Cust_ID`, `Cust_Name`, `Email_ID`) VALUES (88, 'Gay Dixon', 'Dixon.Gay@gmail.com');
INSERT INTO `Delivery_System`.`Customer` (`Cust_ID`, `Cust_Name`, `Email_ID`) VALUES (89, 'Ignatius Jackson', 'Jackson.Ignatius@gmail.com');
INSERT INTO `Delivery_System`.`Customer` (`Cust_ID`, `Cust_Name`, `Email_ID`) VALUES (90, 'Caryn Forbes', 'Forbes.Caryn@gmail.com');
INSERT INTO `Delivery_System`.`Customer` (`Cust_ID`, `Cust_Name`, `Email_ID`) VALUES (91, 'Tanner Rice', 'Rice.Tanner@gmail.com');
INSERT INTO `Delivery_System`.`Customer` (`Cust_ID`, `Cust_Name`, `Email_ID`) VALUES (92, 'Lee Koch', 'Koch.Lee@gmail.com');
INSERT INTO `Delivery_System`.`Customer` (`Cust_ID`, `Cust_Name`, `Email_ID`) VALUES (93, 'Buckminster Lambert', 'Lambert.Buckminster@gmail.com');
INSERT INTO `Delivery_System`.`Customer` (`Cust_ID`, `Cust_Name`, `Email_ID`) VALUES (94, 'Alfreda Wiggins', 'Wiggins.Alfreda@gmail.com');
INSERT INTO `Delivery_System`.`Customer` (`Cust_ID`, `Cust_Name`, `Email_ID`) VALUES (95, 'Charles Whitney', 'Whitney.Charles@gmail.com');
INSERT INTO `Delivery_System`.`Customer` (`Cust_ID`, `Cust_Name`, `Email_ID`) VALUES (96, 'Samantha William', 'William.Samantha@gmail.com');
INSERT INTO `Delivery_System`.`Customer` (`Cust_ID`, `Cust_Name`, `Email_ID`) VALUES (97, 'Mohammad Gamble', 'Gamble.Mohammad@gmail.com');
INSERT INTO `Delivery_System`.`Customer` (`Cust_ID`, `Cust_Name`, `Email_ID`) VALUES (98, 'Bradley Fletcher', 'Fletcher.Bradley@gmail.com');
INSERT INTO `Delivery_System`.`Customer` (`Cust_ID`, `Cust_Name`, `Email_ID`) VALUES (99, 'Ivana Alston', 'Alston.Ivana@gmail.com');
INSERT INTO `Delivery_System`.`Customer` (`Cust_ID`, `Cust_Name`, `Email_ID`) VALUES (100, 'Evangeline Bowers', 'Bowers.Evangeline@gmail.com');

COMMIT;


-- -----------------------------------------------------
-- Data for table `Delivery_System`.`Zip_Code`
-- -----------------------------------------------------
START TRANSACTION;
USE `Delivery_System`;
INSERT INTO `Delivery_System`.`Zip_Code` (`Zip_Code`, `City`, `State`, `Longitude`, `Latitude`) VALUES (12111, 'Rochester', 'MN', '-74.36066', '-91.19715');
INSERT INTO `Delivery_System`.`Zip_Code` (`Zip_Code`, `City`, `State`, `Longitude`, `Latitude`) VALUES (12120, 'Rochester', 'MN', '-74.36066', '-91.19715');
INSERT INTO `Delivery_System`.`Zip_Code` (`Zip_Code`, `City`, `State`, `Longitude`, `Latitude`) VALUES (12131, 'Rochester', 'MN', '-74.36066', '-91.19715');
INSERT INTO `Delivery_System`.`Zip_Code` (`Zip_Code`, `City`, `State`, `Longitude`, `Latitude`) VALUES (12189, 'Rochester', 'MN', '-74.36066', '-91.19715');
INSERT INTO `Delivery_System`.`Zip_Code` (`Zip_Code`, `City`, `State`, `Longitude`, `Latitude`) VALUES (12192, 'Rochester', 'MN', '-74.36066', '-91.19715');
INSERT INTO `Delivery_System`.`Zip_Code` (`Zip_Code`, `City`, `State`, `Longitude`, `Latitude`) VALUES (12325, 'Auburn', 'ME', '-54.72139', '-135.51108');
INSERT INTO `Delivery_System`.`Zip_Code` (`Zip_Code`, `City`, `State`, `Longitude`, `Latitude`) VALUES (12364, 'Auburn', 'ME', '-54.72139', '-135.51108');
INSERT INTO `Delivery_System`.`Zip_Code` (`Zip_Code`, `City`, `State`, `Longitude`, `Latitude`) VALUES (12389, 'Auburn', 'ME', '-54.72139', '-135.51108');
INSERT INTO `Delivery_System`.`Zip_Code` (`Zip_Code`, `City`, `State`, `Longitude`, `Latitude`) VALUES (12391, 'Auburn', 'ME', '-54.72139', '-135.51108');
INSERT INTO `Delivery_System`.`Zip_Code` (`Zip_Code`, `City`, `State`, `Longitude`, `Latitude`) VALUES (12393, 'Auburn', 'ME', '-54.72139', '-135.51108');
INSERT INTO `Delivery_System`.`Zip_Code` (`Zip_Code`, `City`, `State`, `Longitude`, `Latitude`) VALUES (17830, 'Lakewood', 'CO', '59.08877', '110.29145');
INSERT INTO `Delivery_System`.`Zip_Code` (`Zip_Code`, `City`, `State`, `Longitude`, `Latitude`) VALUES (17842, 'Lakewood', 'CO', '59.08877', '110.29145');
INSERT INTO `Delivery_System`.`Zip_Code` (`Zip_Code`, `City`, `State`, `Longitude`, `Latitude`) VALUES (17846, 'Lakewood', 'CO', '59.08877', '110.29145');
INSERT INTO `Delivery_System`.`Zip_Code` (`Zip_Code`, `City`, `State`, `Longitude`, `Latitude`) VALUES (17845, 'Lakewood', 'CO', '59.08877', '110.29145');
INSERT INTO `Delivery_System`.`Zip_Code` (`Zip_Code`, `City`, `State`, `Longitude`, `Latitude`) VALUES (17854, 'Lakewood', 'CO', '59.08877', '110.29145');
INSERT INTO `Delivery_System`.`Zip_Code` (`Zip_Code`, `City`, `State`, `Longitude`, `Latitude`) VALUES (20836, 'Jackson', 'MS', '31.88778', '71.77785');
INSERT INTO `Delivery_System`.`Zip_Code` (`Zip_Code`, `City`, `State`, `Longitude`, `Latitude`) VALUES (20862, 'Jackson', 'MS', '31.88778', '71.77785');
INSERT INTO `Delivery_System`.`Zip_Code` (`Zip_Code`, `City`, `State`, `Longitude`, `Latitude`) VALUES (20875, 'Jackson', 'MS', '31.88778', '71.77785');
INSERT INTO `Delivery_System`.`Zip_Code` (`Zip_Code`, `City`, `State`, `Longitude`, `Latitude`) VALUES (20885, 'Jackson', 'MS', '31.88778', '71.77785');
INSERT INTO `Delivery_System`.`Zip_Code` (`Zip_Code`, `City`, `State`, `Longitude`, `Latitude`) VALUES (20898, 'Jackson', 'MS', '31.88778', '71.77785');
INSERT INTO `Delivery_System`.`Zip_Code` (`Zip_Code`, `City`, `State`, `Longitude`, `Latitude`) VALUES (25623, 'Anchorage', 'AK', '13.47488', '156.05183');
INSERT INTO `Delivery_System`.`Zip_Code` (`Zip_Code`, `City`, `State`, `Longitude`, `Latitude`) VALUES (25648, 'Anchorage', 'AK', '13.47488', '156.05183');
INSERT INTO `Delivery_System`.`Zip_Code` (`Zip_Code`, `City`, `State`, `Longitude`, `Latitude`) VALUES (25654, 'Anchorage', 'AK', '13.47488', '156.05183');
INSERT INTO `Delivery_System`.`Zip_Code` (`Zip_Code`, `City`, `State`, `Longitude`, `Latitude`) VALUES (25664, 'Anchorage', 'AK', '13.47488', '156.05183');
INSERT INTO `Delivery_System`.`Zip_Code` (`Zip_Code`, `City`, `State`, `Longitude`, `Latitude`) VALUES (25681, 'Anchorage', 'AK', '13.47488', '156.05183');
INSERT INTO `Delivery_System`.`Zip_Code` (`Zip_Code`, `City`, `State`, `Longitude`, `Latitude`) VALUES (28732, 'North Las Vegas', 'NV', '28.11227', '-111.6087');
INSERT INTO `Delivery_System`.`Zip_Code` (`Zip_Code`, `City`, `State`, `Longitude`, `Latitude`) VALUES (28733, 'North Las Vegas', 'NV', '28.11227', '-111.6087');
INSERT INTO `Delivery_System`.`Zip_Code` (`Zip_Code`, `City`, `State`, `Longitude`, `Latitude`) VALUES (28762, 'North Las Vegas', 'NV', '28.11227', '-111.6087');
INSERT INTO `Delivery_System`.`Zip_Code` (`Zip_Code`, `City`, `State`, `Longitude`, `Latitude`) VALUES (28763, 'North Las Vegas', 'NV', '28.11227', '-111.6087');
INSERT INTO `Delivery_System`.`Zip_Code` (`Zip_Code`, `City`, `State`, `Longitude`, `Latitude`) VALUES (28768, 'North Las Vegas', 'NV', '28.11227', '-111.6087');
INSERT INTO `Delivery_System`.`Zip_Code` (`Zip_Code`, `City`, `State`, `Longitude`, `Latitude`) VALUES (31822, 'Bridgeport', 'CT', '-81.98785', '-16.19029');
INSERT INTO `Delivery_System`.`Zip_Code` (`Zip_Code`, `City`, `State`, `Longitude`, `Latitude`) VALUES (31834, 'Bridgeport', 'CT', '-81.98785', '-16.19029');
INSERT INTO `Delivery_System`.`Zip_Code` (`Zip_Code`, `City`, `State`, `Longitude`, `Latitude`) VALUES (31841, 'Bridgeport', 'CT', '-81.98785', '-16.19029');
INSERT INTO `Delivery_System`.`Zip_Code` (`Zip_Code`, `City`, `State`, `Longitude`, `Latitude`) VALUES (31849, 'Bridgeport', 'CT', '-81.98785', '-16.19029');
INSERT INTO `Delivery_System`.`Zip_Code` (`Zip_Code`, `City`, `State`, `Longitude`, `Latitude`) VALUES (31874, 'Bridgeport', 'CT', '-81.98785', '-16.19029');
INSERT INTO `Delivery_System`.`Zip_Code` (`Zip_Code`, `City`, `State`, `Longitude`, `Latitude`) VALUES (45425, 'Bridgeport', 'MA', '-44.05942', '-11.65853');
INSERT INTO `Delivery_System`.`Zip_Code` (`Zip_Code`, `City`, `State`, `Longitude`, `Latitude`) VALUES (45429, 'Bridgeport', 'MA', '-44.05942', '-11.65853');
INSERT INTO `Delivery_System`.`Zip_Code` (`Zip_Code`, `City`, `State`, `Longitude`, `Latitude`) VALUES (45430, 'Bridgeport', 'MA', '-44.05942', '-11.65853');
INSERT INTO `Delivery_System`.`Zip_Code` (`Zip_Code`, `City`, `State`, `Longitude`, `Latitude`) VALUES (45491, 'Bridgeport', 'MA', '-44.05942', '-11.65853');
INSERT INTO `Delivery_System`.`Zip_Code` (`Zip_Code`, `City`, `State`, `Longitude`, `Latitude`) VALUES (45493, 'Bridgeport', 'MA', '-44.05942', '-11.65853');
INSERT INTO `Delivery_System`.`Zip_Code` (`Zip_Code`, `City`, `State`, `Longitude`, `Latitude`) VALUES (48314, 'Bloomington', 'MN', '51.74505', '133.23301');
INSERT INTO `Delivery_System`.`Zip_Code` (`Zip_Code`, `City`, `State`, `Longitude`, `Latitude`) VALUES (48344, 'Bloomington', 'MN', '51.74505', '133.23301');
INSERT INTO `Delivery_System`.`Zip_Code` (`Zip_Code`, `City`, `State`, `Longitude`, `Latitude`) VALUES (48350, 'Bloomington', 'MN', '51.74505', '133.23301');
INSERT INTO `Delivery_System`.`Zip_Code` (`Zip_Code`, `City`, `State`, `Longitude`, `Latitude`) VALUES (48356, 'Bloomington', 'MN', '51.74505', '133.23301');
INSERT INTO `Delivery_System`.`Zip_Code` (`Zip_Code`, `City`, `State`, `Longitude`, `Latitude`) VALUES (48363, 'Bloomington', 'MN', '51.74505', '133.23301');
INSERT INTO `Delivery_System`.`Zip_Code` (`Zip_Code`, `City`, `State`, `Longitude`, `Latitude`) VALUES (53735, 'South Bend', 'IN', '62.85077', '-106.12965');
INSERT INTO `Delivery_System`.`Zip_Code` (`Zip_Code`, `City`, `State`, `Longitude`, `Latitude`) VALUES (53740, 'South Bend', 'IN', '62.85077', '-106.12965');
INSERT INTO `Delivery_System`.`Zip_Code` (`Zip_Code`, `City`, `State`, `Longitude`, `Latitude`) VALUES (53742, 'South Bend', 'IN', '62.85077', '-106.12965');
INSERT INTO `Delivery_System`.`Zip_Code` (`Zip_Code`, `City`, `State`, `Longitude`, `Latitude`) VALUES (53764, 'South Bend', 'IN', '62.85077', '-106.12965');
INSERT INTO `Delivery_System`.`Zip_Code` (`Zip_Code`, `City`, `State`, `Longitude`, `Latitude`) VALUES (53790, 'South Bend', 'IN', '62.85077', '-106.12965');
INSERT INTO `Delivery_System`.`Zip_Code` (`Zip_Code`, `City`, `State`, `Longitude`, `Latitude`) VALUES (54324, 'Rochester ', 'MN', '-79.35759', '-101.15342');
INSERT INTO `Delivery_System`.`Zip_Code` (`Zip_Code`, `City`, `State`, `Longitude`, `Latitude`) VALUES (54330, 'Rochester ', 'MN', '-79.35759', '-101.15342');
INSERT INTO `Delivery_System`.`Zip_Code` (`Zip_Code`, `City`, `State`, `Longitude`, `Latitude`) VALUES (54334, 'Rochester ', 'MN', '-79.35759', '-101.15342');
INSERT INTO `Delivery_System`.`Zip_Code` (`Zip_Code`, `City`, `State`, `Longitude`, `Latitude`) VALUES (54360, 'Rochester ', 'MN', '-79.35759', '-101.15342');
INSERT INTO `Delivery_System`.`Zip_Code` (`Zip_Code`, `City`, `State`, `Longitude`, `Latitude`) VALUES (54363, 'Rochester ', 'MN', '-79.35759', '-101.15342');
INSERT INTO `Delivery_System`.`Zip_Code` (`Zip_Code`, `City`, `State`, `Longitude`, `Latitude`) VALUES (61637, 'Rochester', 'MS', '48.49978', '82.6659');
INSERT INTO `Delivery_System`.`Zip_Code` (`Zip_Code`, `City`, `State`, `Longitude`, `Latitude`) VALUES (61672, 'Rochester', 'MS', '48.49978', '82.6659');
INSERT INTO `Delivery_System`.`Zip_Code` (`Zip_Code`, `City`, `State`, `Longitude`, `Latitude`) VALUES (61694, 'Rochester', 'MS', '48.49978', '82.6659');
INSERT INTO `Delivery_System`.`Zip_Code` (`Zip_Code`, `City`, `State`, `Longitude`, `Latitude`) VALUES (61699, 'Rochester', 'MS', '48.49978', '82.6659');
INSERT INTO `Delivery_System`.`Zip_Code` (`Zip_Code`, `City`, `State`, `Longitude`, `Latitude`) VALUES (61698, 'Rochester', 'MS', '48.49978', '82.6659');
INSERT INTO `Delivery_System`.`Zip_Code` (`Zip_Code`, `City`, `State`, `Longitude`, `Latitude`) VALUES (67823, 'West Valley City', 'UT', '-50.20901', '67.36657');
INSERT INTO `Delivery_System`.`Zip_Code` (`Zip_Code`, `City`, `State`, `Longitude`, `Latitude`) VALUES (67835, 'West Valley City', 'UT', '-50.20901', '67.36657');
INSERT INTO `Delivery_System`.`Zip_Code` (`Zip_Code`, `City`, `State`, `Longitude`, `Latitude`) VALUES (67845, 'West Valley City', 'UT', '-50.20901', '67.36657');
INSERT INTO `Delivery_System`.`Zip_Code` (`Zip_Code`, `City`, `State`, `Longitude`, `Latitude`) VALUES (67866, 'West Valley City', 'UT', '-50.20901', '67.36657');
INSERT INTO `Delivery_System`.`Zip_Code` (`Zip_Code`, `City`, `State`, `Longitude`, `Latitude`) VALUES (67881, 'West Valley City', 'UT', '-50.20901', '67.36657');
INSERT INTO `Delivery_System`.`Zip_Code` (`Zip_Code`, `City`, `State`, `Longitude`, `Latitude`) VALUES (76517, 'Athens', 'GA', '-72.7175', '-114.42198');
INSERT INTO `Delivery_System`.`Zip_Code` (`Zip_Code`, `City`, `State`, `Longitude`, `Latitude`) VALUES (76537, 'Athens', 'GA', '-72.7175', '-114.42198');
INSERT INTO `Delivery_System`.`Zip_Code` (`Zip_Code`, `City`, `State`, `Longitude`, `Latitude`) VALUES (76546, 'Athens', 'GA', '-72.7175', '-114.42198');
INSERT INTO `Delivery_System`.`Zip_Code` (`Zip_Code`, `City`, `State`, `Longitude`, `Latitude`) VALUES (76584, 'Athens', 'GA', '-72.7175', '-114.42198');
INSERT INTO `Delivery_System`.`Zip_Code` (`Zip_Code`, `City`, `State`, `Longitude`, `Latitude`) VALUES (76588, 'Athens', 'GA', '-72.7175', '-114.42198');

COMMIT;


-- -----------------------------------------------------
-- Data for table `Delivery_System`.`CustShipping_Address`
-- -----------------------------------------------------
START TRANSACTION;
USE `Delivery_System`;
INSERT INTO `Delivery_System`.`CustShipping_Address` (`ShippingAddress_ID`, `Shipping_Name`, `Street_1`, `Zip_Code`) VALUES (15501, 'Reuben Z. Higgins', '760 Consequat Av.', 76588);
INSERT INTO `Delivery_System`.`CustShipping_Address` (`ShippingAddress_ID`, `Shipping_Name`, `Street_1`, `Zip_Code`) VALUES (15502, 'Caleb H. Farrell', 'Ap #204-1420 Scelerisque Ave', 76517);
INSERT INTO `Delivery_System`.`CustShipping_Address` (`ShippingAddress_ID`, `Shipping_Name`, `Street_1`, `Zip_Code`) VALUES (15503, 'Blaine A. Aguirre', 'P.O. Box 945, 8682 Aliquet Road', 76537);
INSERT INTO `Delivery_System`.`CustShipping_Address` (`ShippingAddress_ID`, `Shipping_Name`, `Street_1`, `Zip_Code`) VALUES (15504, 'Olga R. Luna', '6952 Eget Ave', 76546);
INSERT INTO `Delivery_System`.`CustShipping_Address` (`ShippingAddress_ID`, `Shipping_Name`, `Street_1`, `Zip_Code`) VALUES (15505, 'Indigo Z. Moon', 'Ap #202-1809 Mollis Av.', 76584);
INSERT INTO `Delivery_System`.`CustShipping_Address` (`ShippingAddress_ID`, `Shipping_Name`, `Street_1`, `Zip_Code`) VALUES (15506, 'Idona W. Hughes', 'Ap #548-520 Egestas. St.', 67823);
INSERT INTO `Delivery_System`.`CustShipping_Address` (`ShippingAddress_ID`, `Shipping_Name`, `Street_1`, `Zip_Code`) VALUES (15507, 'Ruby Q. Holland', 'Ap #721-801 Cras Rd.', 67866);
INSERT INTO `Delivery_System`.`CustShipping_Address` (`ShippingAddress_ID`, `Shipping_Name`, `Street_1`, `Zip_Code`) VALUES (15508, 'Hiroko T. Pruitt', 'P.O. Box 301, 1174 Pede, Road', 67835);
INSERT INTO `Delivery_System`.`CustShipping_Address` (`ShippingAddress_ID`, `Shipping_Name`, `Street_1`, `Zip_Code`) VALUES (15509, 'Keegan T. Callahan', 'Ap #961-145 Dignissim. St.', 67881);
INSERT INTO `Delivery_System`.`CustShipping_Address` (`ShippingAddress_ID`, `Shipping_Name`, `Street_1`, `Zip_Code`) VALUES (15510, 'Aimee D. Hendrix', 'P.O. Box 206, 8881 Semper Street', 67845);
INSERT INTO `Delivery_System`.`CustShipping_Address` (`ShippingAddress_ID`, `Shipping_Name`, `Street_1`, `Zip_Code`) VALUES (15511, 'Melanie D. Hart', 'Ap #370-111 Netus Street', 54324);
INSERT INTO `Delivery_System`.`CustShipping_Address` (`ShippingAddress_ID`, `Shipping_Name`, `Street_1`, `Zip_Code`) VALUES (15512, 'Lana S. Thomas', '983-3631 Amet Av.', 54334);
INSERT INTO `Delivery_System`.`CustShipping_Address` (`ShippingAddress_ID`, `Shipping_Name`, `Street_1`, `Zip_Code`) VALUES (15513, 'Damian O. Page', '728-5900 Dolor. Road', 54363);
INSERT INTO `Delivery_System`.`CustShipping_Address` (`ShippingAddress_ID`, `Shipping_Name`, `Street_1`, `Zip_Code`) VALUES (15514, 'Edan N. Madden', 'P.O. Box 289, 2065 Nibh Avenue', 54330);
INSERT INTO `Delivery_System`.`CustShipping_Address` (`ShippingAddress_ID`, `Shipping_Name`, `Street_1`, `Zip_Code`) VALUES (15515, 'Xerxes Q. Russo', '888-7303 Nunc. Avenue', 54360);
INSERT INTO `Delivery_System`.`CustShipping_Address` (`ShippingAddress_ID`, `Shipping_Name`, `Street_1`, `Zip_Code`) VALUES (15516, 'Urielle G. Ball', 'P.O. Box 160, 2417 Eget Rd.', 61672);
INSERT INTO `Delivery_System`.`CustShipping_Address` (`ShippingAddress_ID`, `Shipping_Name`, `Street_1`, `Zip_Code`) VALUES (15517, 'Chava H. Collins', '248-6926 Lacinia Rd.', 61694);
INSERT INTO `Delivery_System`.`CustShipping_Address` (`ShippingAddress_ID`, `Shipping_Name`, `Street_1`, `Zip_Code`) VALUES (15518, 'Russell S. Ashley', '202-5469 Donec St.', 61699);
INSERT INTO `Delivery_System`.`CustShipping_Address` (`ShippingAddress_ID`, `Shipping_Name`, `Street_1`, `Zip_Code`) VALUES (15519, 'Grace P. Hayes', 'P.O. Box 877, 5795 Erat St.', 61637);
INSERT INTO `Delivery_System`.`CustShipping_Address` (`ShippingAddress_ID`, `Shipping_Name`, `Street_1`, `Zip_Code`) VALUES (15520, 'Pandora I. Duncan', '9176 Proin St.', 61699);
INSERT INTO `Delivery_System`.`CustShipping_Address` (`ShippingAddress_ID`, `Shipping_Name`, `Street_1`, `Zip_Code`) VALUES (15521, 'Wesley J. Rowe', 'P.O. Box 120, 7470 Gravida. Rd.', 12111);
INSERT INTO `Delivery_System`.`CustShipping_Address` (`ShippingAddress_ID`, `Shipping_Name`, `Street_1`, `Zip_Code`) VALUES (15522, 'Duncan A. William', 'P.O. Box 965, 2644 Libero Street', 12131);
INSERT INTO `Delivery_System`.`CustShipping_Address` (`ShippingAddress_ID`, `Shipping_Name`, `Street_1`, `Zip_Code`) VALUES (15523, 'Kenneth Q. Alexander', 'Ap #725-5059 Nibh. St.', 12120);
INSERT INTO `Delivery_System`.`CustShipping_Address` (`ShippingAddress_ID`, `Shipping_Name`, `Street_1`, `Zip_Code`) VALUES (15524, 'Armando A. Dean', '383-5544 Nunc Rd.', 12192);
INSERT INTO `Delivery_System`.`CustShipping_Address` (`ShippingAddress_ID`, `Shipping_Name`, `Street_1`, `Zip_Code`) VALUES (15525, 'Hilel D. Black', '543-769 Nisi. Avenue', 17854);
INSERT INTO `Delivery_System`.`CustShipping_Address` (`ShippingAddress_ID`, `Shipping_Name`, `Street_1`, `Zip_Code`) VALUES (15526, 'Herrod R. Dawson', '457 Id, Street', 17830);
INSERT INTO `Delivery_System`.`CustShipping_Address` (`ShippingAddress_ID`, `Shipping_Name`, `Street_1`, `Zip_Code`) VALUES (15527, 'Kato W. Freeman', 'P.O. Box 902, 5119 Velit St.', 17845);
INSERT INTO `Delivery_System`.`CustShipping_Address` (`ShippingAddress_ID`, `Shipping_Name`, `Street_1`, `Zip_Code`) VALUES (15528, 'Patrick N. Benton', 'Ap #128-9593 Eget, St.', 25681);
INSERT INTO `Delivery_System`.`CustShipping_Address` (`ShippingAddress_ID`, `Shipping_Name`, `Street_1`, `Zip_Code`) VALUES (15529, 'Nash S. Burnett', '9142 Nec Street', 25664);
INSERT INTO `Delivery_System`.`CustShipping_Address` (`ShippingAddress_ID`, `Shipping_Name`, `Street_1`, `Zip_Code`) VALUES (15530, 'Noelani M. Strickland', '418-7274 Suspendisse Av.', 25648);
INSERT INTO `Delivery_System`.`CustShipping_Address` (`ShippingAddress_ID`, `Shipping_Name`, `Street_1`, `Zip_Code`) VALUES (15531, 'Salvador S. Ellis', '571-9231 Vulputate, St.', 31822);
INSERT INTO `Delivery_System`.`CustShipping_Address` (`ShippingAddress_ID`, `Shipping_Name`, `Street_1`, `Zip_Code`) VALUES (15532, 'Suki M. Hodge', '5137 Libero. Rd.', 31874);
INSERT INTO `Delivery_System`.`CustShipping_Address` (`ShippingAddress_ID`, `Shipping_Name`, `Street_1`, `Zip_Code`) VALUES (15533, 'Remedios I. Zamora', '6864 Orci Rd.', 31849);
INSERT INTO `Delivery_System`.`CustShipping_Address` (`ShippingAddress_ID`, `Shipping_Name`, `Street_1`, `Zip_Code`) VALUES (15534, 'Regan P. Barber', 'P.O. Box 250, 8170 Urna Rd.', 31834);
INSERT INTO `Delivery_System`.`CustShipping_Address` (`ShippingAddress_ID`, `Shipping_Name`, `Street_1`, `Zip_Code`) VALUES (15535, 'Axel V. Walton', 'P.O. Box 644, 6182 Ut Road', 48314);
INSERT INTO `Delivery_System`.`CustShipping_Address` (`ShippingAddress_ID`, `Shipping_Name`, `Street_1`, `Zip_Code`) VALUES (15536, 'Dustin R. West', '3001 Malesuada St.', 25623);
INSERT INTO `Delivery_System`.`CustShipping_Address` (`ShippingAddress_ID`, `Shipping_Name`, `Street_1`, `Zip_Code`) VALUES (15537, 'Kuame Y. Torres', 'P.O. Box 697, 1789 Nonummy Rd.', 31822);
INSERT INTO `Delivery_System`.`CustShipping_Address` (`ShippingAddress_ID`, `Shipping_Name`, `Street_1`, `Zip_Code`) VALUES (15538, 'Bernard X. Wade', '7985 Vitae Ave', 31874);
INSERT INTO `Delivery_System`.`CustShipping_Address` (`ShippingAddress_ID`, `Shipping_Name`, `Street_1`, `Zip_Code`) VALUES (15539, 'Guinevere Z. Torres', 'P.O. Box 715, 5922 Nec, Street', 31849);
INSERT INTO `Delivery_System`.`CustShipping_Address` (`ShippingAddress_ID`, `Shipping_Name`, `Street_1`, `Zip_Code`) VALUES (15540, 'Mollie E. Barnett', 'Ap #469-6870 Vitae, Street', 31841);
INSERT INTO `Delivery_System`.`CustShipping_Address` (`ShippingAddress_ID`, `Shipping_Name`, `Street_1`, `Zip_Code`) VALUES (15541, 'Reece Z. Eaton', 'Ap #183-3023 Nunc Ave', 48344);
INSERT INTO `Delivery_System`.`CustShipping_Address` (`ShippingAddress_ID`, `Shipping_Name`, `Street_1`, `Zip_Code`) VALUES (15542, 'Joelle E. Fischer', '282-9370 Dignissim Avenue', 48314);
INSERT INTO `Delivery_System`.`CustShipping_Address` (`ShippingAddress_ID`, `Shipping_Name`, `Street_1`, `Zip_Code`) VALUES (15543, 'Taylor R. Cannon', 'P.O. Box 511, 1233 Enim. Rd.', 48356);
INSERT INTO `Delivery_System`.`CustShipping_Address` (`ShippingAddress_ID`, `Shipping_Name`, `Street_1`, `Zip_Code`) VALUES (15544, 'Eden G. Oconnor', 'P.O. Box 389, 8853 Vitae Rd.', 48350);
INSERT INTO `Delivery_System`.`CustShipping_Address` (`ShippingAddress_ID`, `Shipping_Name`, `Street_1`, `Zip_Code`) VALUES (15545, 'Natalie A. Perez', 'P.O. Box 523, 8293 Nunc Street', 48363);
INSERT INTO `Delivery_System`.`CustShipping_Address` (`ShippingAddress_ID`, `Shipping_Name`, `Street_1`, `Zip_Code`) VALUES (15546, 'Ria E. Nguyen', 'Ap #262-5899 Sed St.', 53790);
INSERT INTO `Delivery_System`.`CustShipping_Address` (`ShippingAddress_ID`, `Shipping_Name`, `Street_1`, `Zip_Code`) VALUES (15547, 'Tarik W. Wilkins', '108-8828 Mauris Street', 53735);
INSERT INTO `Delivery_System`.`CustShipping_Address` (`ShippingAddress_ID`, `Shipping_Name`, `Street_1`, `Zip_Code`) VALUES (15548, 'Naomi E. Owens', '563-2752 At Rd.', 53742);
INSERT INTO `Delivery_System`.`CustShipping_Address` (`ShippingAddress_ID`, `Shipping_Name`, `Street_1`, `Zip_Code`) VALUES (15549, 'Clarke M. Grant', 'Ap #643-3824 Enim. Rd.', 12325);
INSERT INTO `Delivery_System`.`CustShipping_Address` (`ShippingAddress_ID`, `Shipping_Name`, `Street_1`, `Zip_Code`) VALUES (15550, 'Samuel Q. Gutierrez', 'Ap #456-3460 Eleifend Road', 12393);
INSERT INTO `Delivery_System`.`CustShipping_Address` (`ShippingAddress_ID`, `Shipping_Name`, `Street_1`, `Zip_Code`) VALUES (15551, 'Casey V. Hewitt', 'Ap #269-9399 Adipiscing Road', 20885);
INSERT INTO `Delivery_System`.`CustShipping_Address` (`ShippingAddress_ID`, `Shipping_Name`, `Street_1`, `Zip_Code`) VALUES (15552, 'Kessie K. Forbes', '397-4998 Iaculis Avenue', 45491);
INSERT INTO `Delivery_System`.`CustShipping_Address` (`ShippingAddress_ID`, `Shipping_Name`, `Street_1`, `Zip_Code`) VALUES (15553, 'Quamar S. Adkins', '9001 Ac Rd.', 45429);
INSERT INTO `Delivery_System`.`CustShipping_Address` (`ShippingAddress_ID`, `Shipping_Name`, `Street_1`, `Zip_Code`) VALUES (15554, 'Catherine E. Randolph', '725-647 Cum Avenue', 45493);
INSERT INTO `Delivery_System`.`CustShipping_Address` (`ShippingAddress_ID`, `Shipping_Name`, `Street_1`, `Zip_Code`) VALUES (15555, 'Hanae F. Delgado', '461-1662 Cursus Ave', 28733);
INSERT INTO `Delivery_System`.`CustShipping_Address` (`ShippingAddress_ID`, `Shipping_Name`, `Street_1`, `Zip_Code`) VALUES (15556, 'Debra N. Adkins', '6826 Lectus. Street', 28762);
INSERT INTO `Delivery_System`.`CustShipping_Address` (`ShippingAddress_ID`, `Shipping_Name`, `Street_1`, `Zip_Code`) VALUES (15557, 'Colby K. Hendrix', 'Ap #203-3241 Dui, Ave', 28768);
INSERT INTO `Delivery_System`.`CustShipping_Address` (`ShippingAddress_ID`, `Shipping_Name`, `Street_1`, `Zip_Code`) VALUES (15558, 'Maile E. Holloway', 'Ap #918-2725 Fusce Road', 76588);
INSERT INTO `Delivery_System`.`CustShipping_Address` (`ShippingAddress_ID`, `Shipping_Name`, `Street_1`, `Zip_Code`) VALUES (15559, 'Nash I. Mclaughlin', 'P.O. Box 887, 868 Tellus. Rd.', 76517);
INSERT INTO `Delivery_System`.`CustShipping_Address` (`ShippingAddress_ID`, `Shipping_Name`, `Street_1`, `Zip_Code`) VALUES (15560, 'Noelani M. Howell', '6532 Fringilla. St.', 76537);
INSERT INTO `Delivery_System`.`CustShipping_Address` (`ShippingAddress_ID`, `Shipping_Name`, `Street_1`, `Zip_Code`) VALUES (15561, 'Donovan Q. Crane', 'P.O. Box 541, 7732 Non Road', 76546);
INSERT INTO `Delivery_System`.`CustShipping_Address` (`ShippingAddress_ID`, `Shipping_Name`, `Street_1`, `Zip_Code`) VALUES (15562, 'Imogene O. Nichols', '527 At Rd.', 76584);
INSERT INTO `Delivery_System`.`CustShipping_Address` (`ShippingAddress_ID`, `Shipping_Name`, `Street_1`, `Zip_Code`) VALUES (15563, 'Yolanda T. Ashley', '345-7157 Lacus. Street', 67823);
INSERT INTO `Delivery_System`.`CustShipping_Address` (`ShippingAddress_ID`, `Shipping_Name`, `Street_1`, `Zip_Code`) VALUES (15564, 'Jayme O. Hodge', 'P.O. Box 628, 854 Mi Ave', 67866);
INSERT INTO `Delivery_System`.`CustShipping_Address` (`ShippingAddress_ID`, `Shipping_Name`, `Street_1`, `Zip_Code`) VALUES (15565, 'Stacey U. Mcdonald', 'Ap #326-5454 Sapien Ave', 67881);
INSERT INTO `Delivery_System`.`CustShipping_Address` (`ShippingAddress_ID`, `Shipping_Name`, `Street_1`, `Zip_Code`) VALUES (15566, 'Dillon Q. Pierce', 'Ap #764-2417 Porttitor St.', 17830);
INSERT INTO `Delivery_System`.`CustShipping_Address` (`ShippingAddress_ID`, `Shipping_Name`, `Street_1`, `Zip_Code`) VALUES (15567, 'Prescott X. Whitfield', '3911 Semper. Ave', 17845);
INSERT INTO `Delivery_System`.`CustShipping_Address` (`ShippingAddress_ID`, `Shipping_Name`, `Street_1`, `Zip_Code`) VALUES (15568, 'Kelly D. Hays', '9793 Sit St.', 25681);
INSERT INTO `Delivery_System`.`CustShipping_Address` (`ShippingAddress_ID`, `Shipping_Name`, `Street_1`, `Zip_Code`) VALUES (15569, 'Kellie S. Vaughn', '9190 Vitae Street', 25654);
INSERT INTO `Delivery_System`.`CustShipping_Address` (`ShippingAddress_ID`, `Shipping_Name`, `Street_1`, `Zip_Code`) VALUES (15570, 'Freya K. Russo', '3078 Mauris Road', 25664);
INSERT INTO `Delivery_System`.`CustShipping_Address` (`ShippingAddress_ID`, `Shipping_Name`, `Street_1`, `Zip_Code`) VALUES (15571, 'Fuller T. Massey', 'Ap #934-571 Elit, St.', 25648);
INSERT INTO `Delivery_System`.`CustShipping_Address` (`ShippingAddress_ID`, `Shipping_Name`, `Street_1`, `Zip_Code`) VALUES (15572, 'Mary L. Thompson', 'P.O. Box 377, 5783 Sollicitudin Road', 25623);
INSERT INTO `Delivery_System`.`CustShipping_Address` (`ShippingAddress_ID`, `Shipping_Name`, `Street_1`, `Zip_Code`) VALUES (15573, 'Vernon P. Vega', '8984 Eu, Rd.', 31822);
INSERT INTO `Delivery_System`.`CustShipping_Address` (`ShippingAddress_ID`, `Shipping_Name`, `Street_1`, `Zip_Code`) VALUES (15574, 'Patience E. Olson', 'P.O. Box 886, 3220 Faucibus Rd.', 31874);
INSERT INTO `Delivery_System`.`CustShipping_Address` (`ShippingAddress_ID`, `Shipping_Name`, `Street_1`, `Zip_Code`) VALUES (15575, 'Reese Z. Oneal', 'Ap #487-1952 Sed Rd.', 31849);
INSERT INTO `Delivery_System`.`CustShipping_Address` (`ShippingAddress_ID`, `Shipping_Name`, `Street_1`, `Zip_Code`) VALUES (15576, 'Shana F. Keller', 'P.O. Box 433, 7551 Ultrices St.', 31834);
INSERT INTO `Delivery_System`.`CustShipping_Address` (`ShippingAddress_ID`, `Shipping_Name`, `Street_1`, `Zip_Code`) VALUES (15577, 'Casey F. Robinson', 'P.O. Box 257, 4708 Praesent Road', 31841);
INSERT INTO `Delivery_System`.`CustShipping_Address` (`ShippingAddress_ID`, `Shipping_Name`, `Street_1`, `Zip_Code`) VALUES (15578, 'Malik A. Yates', '635-7485 Nunc Road', 48344);
INSERT INTO `Delivery_System`.`CustShipping_Address` (`ShippingAddress_ID`, `Shipping_Name`, `Street_1`, `Zip_Code`) VALUES (15579, 'Marcia X. Huber', '914-4762 Cras Street', 48356);
INSERT INTO `Delivery_System`.`CustShipping_Address` (`ShippingAddress_ID`, `Shipping_Name`, `Street_1`, `Zip_Code`) VALUES (15580, 'Selma W. Young', '702-5601 Euismod Rd.', 48350);
INSERT INTO `Delivery_System`.`CustShipping_Address` (`ShippingAddress_ID`, `Shipping_Name`, `Street_1`, `Zip_Code`) VALUES (15581, 'Kylie E. Peterson', '7993 Tristique Ave', 25623);
INSERT INTO `Delivery_System`.`CustShipping_Address` (`ShippingAddress_ID`, `Shipping_Name`, `Street_1`, `Zip_Code`) VALUES (15582, 'Knox I. Cardenas', 'Ap #573-3592 Libero. Avenue', 31849);
INSERT INTO `Delivery_System`.`CustShipping_Address` (`ShippingAddress_ID`, `Shipping_Name`, `Street_1`, `Zip_Code`) VALUES (15583, 'Lavinia N. Whitehead', '244-542 Faucibus Av.', 31841);
INSERT INTO `Delivery_System`.`CustShipping_Address` (`ShippingAddress_ID`, `Shipping_Name`, `Street_1`, `Zip_Code`) VALUES (15584, 'Haley Y. Sosa', 'Ap #747-6871 Auctor. Ave', 48344);
INSERT INTO `Delivery_System`.`CustShipping_Address` (`ShippingAddress_ID`, `Shipping_Name`, `Street_1`, `Zip_Code`) VALUES (15585, 'Aiko Q. Summers', '4484 Proin Road', 48314);
INSERT INTO `Delivery_System`.`CustShipping_Address` (`ShippingAddress_ID`, `Shipping_Name`, `Street_1`, `Zip_Code`) VALUES (15586, 'Jayme W. Cameron', '502-2091 Fermentum St.', 48350);
INSERT INTO `Delivery_System`.`CustShipping_Address` (`ShippingAddress_ID`, `Shipping_Name`, `Street_1`, `Zip_Code`) VALUES (15587, 'Xantha M. Shannon', '5599 Aliquet. Avenue', 48363);
INSERT INTO `Delivery_System`.`CustShipping_Address` (`ShippingAddress_ID`, `Shipping_Name`, `Street_1`, `Zip_Code`) VALUES (15588, 'Ivan D. Juarez', '344-7660 Elementum Ave', 53764);
INSERT INTO `Delivery_System`.`CustShipping_Address` (`ShippingAddress_ID`, `Shipping_Name`, `Street_1`, `Zip_Code`) VALUES (15589, 'Jerome W. Montgomery', 'Ap #207-2718 Metus. Rd.', 53790);
INSERT INTO `Delivery_System`.`CustShipping_Address` (`ShippingAddress_ID`, `Shipping_Name`, `Street_1`, `Zip_Code`) VALUES (15590, 'Wang H. Flowers', 'P.O. Box 995, 8904 Dictum Road', 53735);
INSERT INTO `Delivery_System`.`CustShipping_Address` (`ShippingAddress_ID`, `Shipping_Name`, `Street_1`, `Zip_Code`) VALUES (15591, 'Blaine R. Bell', 'P.O. Box 188, 6433 Consequat Av.', 53740);
INSERT INTO `Delivery_System`.`CustShipping_Address` (`ShippingAddress_ID`, `Shipping_Name`, `Street_1`, `Zip_Code`) VALUES (15592, 'Calvin H. Mayo', '738-8034 Turpis. Street', 12391);
INSERT INTO `Delivery_System`.`CustShipping_Address` (`ShippingAddress_ID`, `Shipping_Name`, `Street_1`, `Zip_Code`) VALUES (15593, 'Scarlett D. Holman', 'Ap #790-5490 Mauris St.', 12325);
INSERT INTO `Delivery_System`.`CustShipping_Address` (`ShippingAddress_ID`, `Shipping_Name`, `Street_1`, `Zip_Code`) VALUES (15594, 'Ramona Y. Church', 'P.O. Box 834, 3710 Purus, Ave', 12364);
INSERT INTO `Delivery_System`.`CustShipping_Address` (`ShippingAddress_ID`, `Shipping_Name`, `Street_1`, `Zip_Code`) VALUES (15595, 'Shaeleigh V. Ramos', 'P.O. Box 953, 7828 Tempor Av.', 20885);
INSERT INTO `Delivery_System`.`CustShipping_Address` (`ShippingAddress_ID`, `Shipping_Name`, `Street_1`, `Zip_Code`) VALUES (15596, 'Keely A. Moon', '926-8860 Risus. Av.', 45491);
INSERT INTO `Delivery_System`.`CustShipping_Address` (`ShippingAddress_ID`, `Shipping_Name`, `Street_1`, `Zip_Code`) VALUES (15597, 'Upton Y. Shepherd', 'Ap #758-1298 Et Rd.', 45425);
INSERT INTO `Delivery_System`.`CustShipping_Address` (`ShippingAddress_ID`, `Shipping_Name`, `Street_1`, `Zip_Code`) VALUES (15598, 'Oliver G. Klein', 'P.O. Box 435, 9949 Non, St.', 45429);
INSERT INTO `Delivery_System`.`CustShipping_Address` (`ShippingAddress_ID`, `Shipping_Name`, `Street_1`, `Zip_Code`) VALUES (15599, 'Adria U. Skinner', '6835 Euismod St.', 45493);
INSERT INTO `Delivery_System`.`CustShipping_Address` (`ShippingAddress_ID`, `Shipping_Name`, `Street_1`, `Zip_Code`) VALUES (15600, 'Ryan B. Waller', 'P.O. Box 662, 3316 Proin Avenue', 28733);

COMMIT;


-- -----------------------------------------------------
-- Data for table `Delivery_System`.`Vendor`
-- -----------------------------------------------------
START TRANSACTION;
USE `Delivery_System`;
INSERT INTO `Delivery_System`.`Vendor` (`Vendor_ID`, `Vendor_Name`) VALUES (1001, 'Apple');
INSERT INTO `Delivery_System`.`Vendor` (`Vendor_ID`, `Vendor_Name`) VALUES (1002, 'Google');
INSERT INTO `Delivery_System`.`Vendor` (`Vendor_ID`, `Vendor_Name`) VALUES (1003, 'Forever 21');
INSERT INTO `Delivery_System`.`Vendor` (`Vendor_ID`, `Vendor_Name`) VALUES (1004, 'H and M');
INSERT INTO `Delivery_System`.`Vendor` (`Vendor_ID`, `Vendor_Name`) VALUES (1005, 'Macys');
INSERT INTO `Delivery_System`.`Vendor` (`Vendor_ID`, `Vendor_Name`) VALUES (1006, 'Dell');
INSERT INTO `Delivery_System`.`Vendor` (`Vendor_ID`, `Vendor_Name`) VALUES (1007, 'LG');
INSERT INTO `Delivery_System`.`Vendor` (`Vendor_ID`, `Vendor_Name`) VALUES (1008, 'Nike');
INSERT INTO `Delivery_System`.`Vendor` (`Vendor_ID`, `Vendor_Name`) VALUES (1009, 'Addidas');
INSERT INTO `Delivery_System`.`Vendor` (`Vendor_ID`, `Vendor_Name`) VALUES (1010, 'Swatch');
INSERT INTO `Delivery_System`.`Vendor` (`Vendor_ID`, `Vendor_Name`) VALUES (1011, 'Fossil');
INSERT INTO `Delivery_System`.`Vendor` (`Vendor_ID`, `Vendor_Name`) VALUES (1012, 'Motorola');
INSERT INTO `Delivery_System`.`Vendor` (`Vendor_ID`, `Vendor_Name`) VALUES (1013, 'Staples');
INSERT INTO `Delivery_System`.`Vendor` (`Vendor_ID`, `Vendor_Name`) VALUES (1014, 'Guess');
INSERT INTO `Delivery_System`.`Vendor` (`Vendor_ID`, `Vendor_Name`) VALUES (1015, 'Samsung');
INSERT INTO `Delivery_System`.`Vendor` (`Vendor_ID`, `Vendor_Name`) VALUES (1016, 'Puma');
INSERT INTO `Delivery_System`.`Vendor` (`Vendor_ID`, `Vendor_Name`) VALUES (1017, 'RadioShack');
INSERT INTO `Delivery_System`.`Vendor` (`Vendor_ID`, `Vendor_Name`) VALUES (1018, 'HP');
INSERT INTO `Delivery_System`.`Vendor` (`Vendor_ID`, `Vendor_Name`) VALUES (1019, 'Abercrombie and Fitch');
INSERT INTO `Delivery_System`.`Vendor` (`Vendor_ID`, `Vendor_Name`) VALUES (1020, 'Bath and Body Work');
INSERT INTO `Delivery_System`.`Vendor` (`Vendor_ID`, `Vendor_Name`) VALUES (1021, 'Body Shop');
INSERT INTO `Delivery_System`.`Vendor` (`Vendor_ID`, `Vendor_Name`) VALUES (1022, 'Chanel');
INSERT INTO `Delivery_System`.`Vendor` (`Vendor_ID`, `Vendor_Name`) VALUES (1023, 'Old Navy');
INSERT INTO `Delivery_System`.`Vendor` (`Vendor_ID`, `Vendor_Name`) VALUES (1024, 'Banana Republic');
INSERT INTO `Delivery_System`.`Vendor` (`Vendor_ID`, `Vendor_Name`) VALUES (1025, 'Steve Madden');
INSERT INTO `Delivery_System`.`Vendor` (`Vendor_ID`, `Vendor_Name`) VALUES (1026, 'Express');
INSERT INTO `Delivery_System`.`Vendor` (`Vendor_ID`, `Vendor_Name`) VALUES (1027, 'UCLA');
INSERT INTO `Delivery_System`.`Vendor` (`Vendor_ID`, `Vendor_Name`) VALUES (1028, 'Hollister');
INSERT INTO `Delivery_System`.`Vendor` (`Vendor_ID`, `Vendor_Name`) VALUES (1029, 'Victorinox');
INSERT INTO `Delivery_System`.`Vendor` (`Vendor_ID`, `Vendor_Name`) VALUES (1030, 'Tommy Hilfiger');
INSERT INTO `Delivery_System`.`Vendor` (`Vendor_ID`, `Vendor_Name`) VALUES (1031, 'Amazon');

COMMIT;


-- -----------------------------------------------------
-- Data for table `Delivery_System`.`Product_Model`
-- -----------------------------------------------------
START TRANSACTION;
USE `Delivery_System`;
INSERT INTO `Delivery_System`.`Product_Model` (`Model_Number`, `Prod_Model_Name`, `Total_Quantity`, `Vendor_ID`) VALUES (7789201, 'Dell Inspiron 800', '116', 1006);
INSERT INTO `Delivery_System`.`Product_Model` (`Model_Number`, `Prod_Model_Name`, `Total_Quantity`, `Vendor_ID`) VALUES (7789202, 'Apple Macbook Air', '511', 1001);
INSERT INTO `Delivery_System`.`Product_Model` (`Model_Number`, `Prod_Model_Name`, `Total_Quantity`, `Vendor_ID`) VALUES (7789203, 'Leopard Print Crop top', '743', 1003);
INSERT INTO `Delivery_System`.`Product_Model` (`Model_Number`, `Prod_Model_Name`, `Total_Quantity`, `Vendor_ID`) VALUES (7789204, 'Acer Xpresso XXl', '154', 1017);
INSERT INTO `Delivery_System`.`Product_Model` (`Model_Number`, `Prod_Model_Name`, `Total_Quantity`, `Vendor_ID`) VALUES (7789205, 'Kate Spade flowery wallet', '339', 1005);
INSERT INTO `Delivery_System`.`Product_Model` (`Model_Number`, `Prod_Model_Name`, `Total_Quantity`, `Vendor_ID`) VALUES (7789206, 'F21 Slim fit jegging', '690', 1003);
INSERT INTO `Delivery_System`.`Product_Model` (`Model_Number`, `Prod_Model_Name`, `Total_Quantity`, `Vendor_ID`) VALUES (7789207, 'H&M Blazer', '412', 1004);
INSERT INTO `Delivery_System`.`Product_Model` (`Model_Number`, `Prod_Model_Name`, `Total_Quantity`, `Vendor_ID`) VALUES (7789208, 'Samsung GT959', '571', 1015);
INSERT INTO `Delivery_System`.`Product_Model` (`Model_Number`, `Prod_Model_Name`, `Total_Quantity`, `Vendor_ID`) VALUES (7789209, 'Clarks Pumps', '817', 1005);
INSERT INTO `Delivery_System`.`Product_Model` (`Model_Number`, `Prod_Model_Name`, `Total_Quantity`, `Vendor_ID`) VALUES (7789210, 'H&M Sweatshirt ', '749', 1004);
INSERT INTO `Delivery_System`.`Product_Model` (`Model_Number`, `Prod_Model_Name`, `Total_Quantity`, `Vendor_ID`) VALUES (7789211, 'Iphone 6', '202', 1001);
INSERT INTO `Delivery_System`.`Product_Model` (`Model_Number`, `Prod_Model_Name`, `Total_Quantity`, `Vendor_ID`) VALUES (7789212, 'MAC Eye Shadow ', '448', 1031);
INSERT INTO `Delivery_System`.`Product_Model` (`Model_Number`, `Prod_Model_Name`, `Total_Quantity`, `Vendor_ID`) VALUES (7789213, 'Sephora Cherry Bloom Lipstick ', '157', 1031);
INSERT INTO `Delivery_System`.`Product_Model` (`Model_Number`, `Prod_Model_Name`, `Total_Quantity`, `Vendor_ID`) VALUES (7789214, 'Victoria Secret Charm ', '538', 1005);
INSERT INTO `Delivery_System`.`Product_Model` (`Model_Number`, `Prod_Model_Name`, `Total_Quantity`, `Vendor_ID`) VALUES (7789215, 'Google Nexus 5 ', '482', 1002);
INSERT INTO `Delivery_System`.`Product_Model` (`Model_Number`, `Prod_Model_Name`, `Total_Quantity`, `Vendor_ID`) VALUES (7789216, 'Zathex bodywash', '767', 1021);
INSERT INTO `Delivery_System`.`Product_Model` (`Model_Number`, `Prod_Model_Name`, `Total_Quantity`, `Vendor_ID`) VALUES (7789217, 'Geoplus', '311', 1023);
INSERT INTO `Delivery_System`.`Product_Model` (`Model_Number`, `Prod_Model_Name`, `Total_Quantity`, `Vendor_ID`) VALUES (7789218, 'Hat Jaycore', '314', 1024);
INSERT INTO `Delivery_System`.`Product_Model` (`Model_Number`, `Prod_Model_Name`, `Total_Quantity`, `Vendor_ID`) VALUES (7789219, 'Stock-Tam', '691', 1025);
INSERT INTO `Delivery_System`.`Product_Model` (`Model_Number`, `Prod_Model_Name`, `Total_Quantity`, `Vendor_ID`) VALUES (7789220, 'Zoomit', '187', 1011);
INSERT INTO `Delivery_System`.`Product_Model` (`Model_Number`, `Prod_Model_Name`, `Total_Quantity`, `Vendor_ID`) VALUES (7789221, 'Voya-Tip', '197', 1002);
INSERT INTO `Delivery_System`.`Product_Model` (`Model_Number`, `Prod_Model_Name`, `Total_Quantity`, `Vendor_ID`) VALUES (7789222, 'U- Mattone', '178', 1018);
INSERT INTO `Delivery_System`.`Product_Model` (`Model_Number`, `Prod_Model_Name`, `Total_Quantity`, `Vendor_ID`) VALUES (7789223, 'Volttom', '916', 1024);
INSERT INTO `Delivery_System`.`Product_Model` (`Model_Number`, `Prod_Model_Name`, `Total_Quantity`, `Vendor_ID`) VALUES (7789224, 'Ap Job', '249', 1011);
INSERT INTO `Delivery_System`.`Product_Model` (`Model_Number`, `Prod_Model_Name`, `Total_Quantity`, `Vendor_ID`) VALUES (7789225, 'Stim Tech', '126', 1014);
INSERT INTO `Delivery_System`.`Product_Model` (`Model_Number`, `Prod_Model_Name`, `Total_Quantity`, `Vendor_ID`) VALUES (7789226, 'Stim String', '310', 1028);
INSERT INTO `Delivery_System`.`Product_Model` (`Model_Number`, `Prod_Model_Name`, `Total_Quantity`, `Vendor_ID`) VALUES (7789227, 'Ontois', '556', 1001);
INSERT INTO `Delivery_System`.`Product_Model` (`Model_Number`, `Prod_Model_Name`, `Total_Quantity`, `Vendor_ID`) VALUES (7789228, 'Medhatkix', '573', 1019);
INSERT INTO `Delivery_System`.`Product_Model` (`Model_Number`, `Prod_Model_Name`, `Total_Quantity`, `Vendor_ID`) VALUES (7789229, 'Tamstrong', '502', 1013);
INSERT INTO `Delivery_System`.`Product_Model` (`Model_Number`, `Prod_Model_Name`, `Total_Quantity`, `Vendor_ID`) VALUES (7789230, 'Domnamtrax', '504', 1012);
INSERT INTO `Delivery_System`.`Product_Model` (`Model_Number`, `Prod_Model_Name`, `Total_Quantity`, `Vendor_ID`) VALUES (7789231, 'Single Finron', '345', 1029);
INSERT INTO `Delivery_System`.`Product_Model` (`Model_Number`, `Prod_Model_Name`, `Total_Quantity`, `Vendor_ID`) VALUES (7789232, 'H&M Blazer', '256', 1023);
INSERT INTO `Delivery_System`.`Product_Model` (`Model_Number`, `Prod_Model_Name`, `Total_Quantity`, `Vendor_ID`) VALUES (7789233, 'Treetough', '904', 1020);
INSERT INTO `Delivery_System`.`Product_Model` (`Model_Number`, `Prod_Model_Name`, `Total_Quantity`, `Vendor_ID`) VALUES (7789234, 'Yearron', '358', 1004);
INSERT INTO `Delivery_System`.`Product_Model` (`Model_Number`, `Prod_Model_Name`, `Total_Quantity`, `Vendor_ID`) VALUES (7789235, 'Sillight', '196', 1002);
INSERT INTO `Delivery_System`.`Product_Model` (`Model_Number`, `Prod_Model_Name`, `Total_Quantity`, `Vendor_ID`) VALUES (7789236, 'Biotamtop', '780', 1023);
INSERT INTO `Delivery_System`.`Product_Model` (`Model_Number`, `Prod_Model_Name`, `Total_Quantity`, `Vendor_ID`) VALUES (7789237, 'Lexifresh', '377', 1007);
INSERT INTO `Delivery_System`.`Product_Model` (`Model_Number`, `Prod_Model_Name`, `Total_Quantity`, `Vendor_ID`) VALUES (7789238, 'Fixron', '294', 1028);
INSERT INTO `Delivery_System`.`Product_Model` (`Model_Number`, `Prod_Model_Name`, `Total_Quantity`, `Vendor_ID`) VALUES (7789239, 'Trippleit', '832', 1008);
INSERT INTO `Delivery_System`.`Product_Model` (`Model_Number`, `Prod_Model_Name`, `Total_Quantity`, `Vendor_ID`) VALUES (7789240, 'Zoomtouch', '123', 1024);
INSERT INTO `Delivery_System`.`Product_Model` (`Model_Number`, `Prod_Model_Name`, `Total_Quantity`, `Vendor_ID`) VALUES (7789241, 'Ran Donex', '400', 1010);
INSERT INTO `Delivery_System`.`Product_Model` (`Model_Number`, `Prod_Model_Name`, `Total_Quantity`, `Vendor_ID`) VALUES (7789242, 'Ozerkix', '583', 1019);
INSERT INTO `Delivery_System`.`Product_Model` (`Model_Number`, `Prod_Model_Name`, `Total_Quantity`, `Vendor_ID`) VALUES (7789243, 'Goldjob', '674', 1029);
INSERT INTO `Delivery_System`.`Product_Model` (`Model_Number`, `Prod_Model_Name`, `Total_Quantity`, `Vendor_ID`) VALUES (7789244, 'Bigtax', '982', 1008);
INSERT INTO `Delivery_System`.`Product_Model` (`Model_Number`, `Prod_Model_Name`, `Total_Quantity`, `Vendor_ID`) VALUES (7789245, 'Sailit', '460', 1005);
INSERT INTO `Delivery_System`.`Product_Model` (`Model_Number`, `Prod_Model_Name`, `Total_Quantity`, `Vendor_ID`) VALUES (7789246, 'Loteco', '197', 1028);
INSERT INTO `Delivery_System`.`Product_Model` (`Model_Number`, `Prod_Model_Name`, `Total_Quantity`, `Vendor_ID`) VALUES (7789247, 'Danlam', '818', 1025);
INSERT INTO `Delivery_System`.`Product_Model` (`Model_Number`, `Prod_Model_Name`, `Total_Quantity`, `Vendor_ID`) VALUES (7789248, 'Goldenkix', '931', 1016);
INSERT INTO `Delivery_System`.`Product_Model` (`Model_Number`, `Prod_Model_Name`, `Total_Quantity`, `Vendor_ID`) VALUES (7789249, 'Holdsailtough', '876', 1011);
INSERT INTO `Delivery_System`.`Product_Model` (`Model_Number`, `Prod_Model_Name`, `Total_Quantity`, `Vendor_ID`) VALUES (7789250, 'Runfax', '954', 1020);
INSERT INTO `Delivery_System`.`Product_Model` (`Model_Number`, `Prod_Model_Name`, `Total_Quantity`, `Vendor_ID`) VALUES (7789251, 'Inlight', '581', 1018);
INSERT INTO `Delivery_System`.`Product_Model` (`Model_Number`, `Prod_Model_Name`, `Total_Quantity`, `Vendor_ID`) VALUES (7789252, 'Goldentamtom', '783', 1002);
INSERT INTO `Delivery_System`.`Product_Model` (`Model_Number`, `Prod_Model_Name`, `Total_Quantity`, `Vendor_ID`) VALUES (7789253, 'Groovezuntouch', '652', 1005);
INSERT INTO `Delivery_System`.`Product_Model` (`Model_Number`, `Prod_Model_Name`, `Total_Quantity`, `Vendor_ID`) VALUES (7789254, 'Tranbam', '218', 1026);
INSERT INTO `Delivery_System`.`Product_Model` (`Model_Number`, `Prod_Model_Name`, `Total_Quantity`, `Vendor_ID`) VALUES (7789255, 'Bioantom', '708', 1003);
INSERT INTO `Delivery_System`.`Product_Model` (`Model_Number`, `Prod_Model_Name`, `Total_Quantity`, `Vendor_ID`) VALUES (7789256, 'Math Hottam', '690', 1003);
INSERT INTO `Delivery_System`.`Product_Model` (`Model_Number`, `Prod_Model_Name`, `Total_Quantity`, `Vendor_ID`) VALUES (7789257, 'Lamhome', '803', 1026);
INSERT INTO `Delivery_System`.`Product_Model` (`Model_Number`, `Prod_Model_Name`, `Total_Quantity`, `Vendor_ID`) VALUES (7789258, 'Hay-Tech', '113', 1002);
INSERT INTO `Delivery_System`.`Product_Model` (`Model_Number`, `Prod_Model_Name`, `Total_Quantity`, `Vendor_ID`) VALUES (7789259, 'Stockjob', '168', 1007);
INSERT INTO `Delivery_System`.`Product_Model` (`Model_Number`, `Prod_Model_Name`, `Total_Quantity`, `Vendor_ID`) VALUES (7789260, 'Faxstrong', '935', 1015);
INSERT INTO `Delivery_System`.`Product_Model` (`Model_Number`, `Prod_Model_Name`, `Total_Quantity`, `Vendor_ID`) VALUES (7789261, 'Runjob', '407', 1004);
INSERT INTO `Delivery_System`.`Product_Model` (`Model_Number`, `Prod_Model_Name`, `Total_Quantity`, `Vendor_ID`) VALUES (7789262, 'Zimron', '735', 1022);
INSERT INTO `Delivery_System`.`Product_Model` (`Model_Number`, `Prod_Model_Name`, `Total_Quantity`, `Vendor_ID`) VALUES (7789263, 'Goldentone', '175', 1027);
INSERT INTO `Delivery_System`.`Product_Model` (`Model_Number`, `Prod_Model_Name`, `Total_Quantity`, `Vendor_ID`) VALUES (7789264, 'Yearin', '819', 1015);
INSERT INTO `Delivery_System`.`Product_Model` (`Model_Number`, `Prod_Model_Name`, `Total_Quantity`, `Vendor_ID`) VALUES (7789265, 'Stanfind', '786', 1018);
INSERT INTO `Delivery_System`.`Product_Model` (`Model_Number`, `Prod_Model_Name`, `Total_Quantity`, `Vendor_ID`) VALUES (7789266, 'Sail Nimwarm', '958', 1004);
INSERT INTO `Delivery_System`.`Product_Model` (`Model_Number`, `Prod_Model_Name`, `Total_Quantity`, `Vendor_ID`) VALUES (7789267, 'Light Soft', '531', 1008);
INSERT INTO `Delivery_System`.`Product_Model` (`Model_Number`, `Prod_Model_Name`, `Total_Quantity`, `Vendor_ID`) VALUES (7789268, 'Tip Jayex', '274', 1026);
INSERT INTO `Delivery_System`.`Product_Model` (`Model_Number`, `Prod_Model_Name`, `Total_Quantity`, `Vendor_ID`) VALUES (7789269, 'Tristom', '538', 1012);
INSERT INTO `Delivery_System`.`Product_Model` (`Model_Number`, `Prod_Model_Name`, `Total_Quantity`, `Vendor_ID`) VALUES (7789270, 'Vivatop', '799', 1021);
INSERT INTO `Delivery_System`.`Product_Model` (`Model_Number`, `Prod_Model_Name`, `Total_Quantity`, `Vendor_ID`) VALUES (7789271, 'Sublux', '818', 1014);
INSERT INTO `Delivery_System`.`Product_Model` (`Model_Number`, `Prod_Model_Name`, `Total_Quantity`, `Vendor_ID`) VALUES (7789272, 'Zundinstring', '619', 1029);
INSERT INTO `Delivery_System`.`Product_Model` (`Model_Number`, `Prod_Model_Name`, `Total_Quantity`, `Vendor_ID`) VALUES (7789273, 'Top Zozlab', '179', 1007);
INSERT INTO `Delivery_System`.`Product_Model` (`Model_Number`, `Prod_Model_Name`, `Total_Quantity`, `Vendor_ID`) VALUES (7789274, 'Apis', '721', 1030);
INSERT INTO `Delivery_System`.`Product_Model` (`Model_Number`, `Prod_Model_Name`, `Total_Quantity`, `Vendor_ID`) VALUES (7789275, 'Kanovenix', '267', 1004);
INSERT INTO `Delivery_System`.`Product_Model` (`Model_Number`, `Prod_Model_Name`, `Total_Quantity`, `Vendor_ID`) VALUES (7789276, 'Tamhome', '711', 1027);
INSERT INTO `Delivery_System`.`Product_Model` (`Model_Number`, `Prod_Model_Name`, `Total_Quantity`, `Vendor_ID`) VALUES (7789277, 'Zoolab', '769', 1030);
INSERT INTO `Delivery_System`.`Product_Model` (`Model_Number`, `Prod_Model_Name`, `Total_Quantity`, `Vendor_ID`) VALUES (7789278, 'Singlebam', '812', 1019);
INSERT INTO `Delivery_System`.`Product_Model` (`Model_Number`, `Prod_Model_Name`, `Total_Quantity`, `Vendor_ID`) VALUES (7789279, 'Quote-Lex', '975', 1001);
INSERT INTO `Delivery_System`.`Product_Model` (`Model_Number`, `Prod_Model_Name`, `Total_Quantity`, `Vendor_ID`) VALUES (7789280, 'X-fix', '374', 1014);
INSERT INTO `Delivery_System`.`Product_Model` (`Model_Number`, `Prod_Model_Name`, `Total_Quantity`, `Vendor_ID`) VALUES (7789281, 'Tanlam', '395', 1018);
INSERT INTO `Delivery_System`.`Product_Model` (`Model_Number`, `Prod_Model_Name`, `Total_Quantity`, `Vendor_ID`) VALUES (7789282, 'Strong Ozeron', '254', 1010);
INSERT INTO `Delivery_System`.`Product_Model` (`Model_Number`, `Prod_Model_Name`, `Total_Quantity`, `Vendor_ID`) VALUES (7789283, 'Nam Sancore', '536', 1008);
INSERT INTO `Delivery_System`.`Product_Model` (`Model_Number`, `Prod_Model_Name`, `Total_Quantity`, `Vendor_ID`) VALUES (7789284, 'San Hotex', '645', 1023);
INSERT INTO `Delivery_System`.`Product_Model` (`Model_Number`, `Prod_Model_Name`, `Total_Quantity`, `Vendor_ID`) VALUES (7789285, 'Toughstring', '816', 1025);
INSERT INTO `Delivery_System`.`Product_Model` (`Model_Number`, `Prod_Model_Name`, `Total_Quantity`, `Vendor_ID`) VALUES (7789286, 'Ecoair', '600', 1029);
INSERT INTO `Delivery_System`.`Product_Model` (`Model_Number`, `Prod_Model_Name`, `Total_Quantity`, `Vendor_ID`) VALUES (7789287, 'Anovefix', '638', 1013);
INSERT INTO `Delivery_System`.`Product_Model` (`Model_Number`, `Prod_Model_Name`, `Total_Quantity`, `Vendor_ID`) VALUES (7789288, 'Alphaing', '494', 1011);
INSERT INTO `Delivery_System`.`Product_Model` (`Model_Number`, `Prod_Model_Name`, `Total_Quantity`, `Vendor_ID`) VALUES (7789289, 'Ronlab', '484', 1029);
INSERT INTO `Delivery_System`.`Product_Model` (`Model_Number`, `Prod_Model_Name`, `Total_Quantity`, `Vendor_ID`) VALUES (7789290, 'Hot Dom', '916', 1012);
INSERT INTO `Delivery_System`.`Product_Model` (`Model_Number`, `Prod_Model_Name`, `Total_Quantity`, `Vendor_ID`) VALUES (7789291, 'Ranzozwarm', '930', 1019);
INSERT INTO `Delivery_System`.`Product_Model` (`Model_Number`, `Prod_Model_Name`, `Total_Quantity`, `Vendor_ID`) VALUES (7789292, 'Holdcof', '185', 1025);
INSERT INTO `Delivery_System`.`Product_Model` (`Model_Number`, `Prod_Model_Name`, `Total_Quantity`, `Vendor_ID`) VALUES (7789293, 'Softtop', '959', 1014);
INSERT INTO `Delivery_System`.`Product_Model` (`Model_Number`, `Prod_Model_Name`, `Total_Quantity`, `Vendor_ID`) VALUES (7789294, 'Dongcore', '915', 1024);
INSERT INTO `Delivery_System`.`Product_Model` (`Model_Number`, `Prod_Model_Name`, `Total_Quantity`, `Vendor_ID`) VALUES (7789295, 'Dondex', '156', 1004);
INSERT INTO `Delivery_System`.`Product_Model` (`Model_Number`, `Prod_Model_Name`, `Total_Quantity`, `Vendor_ID`) VALUES (7789296, 'Silver Zimlux', '456', 1019);
INSERT INTO `Delivery_System`.`Product_Model` (`Model_Number`, `Prod_Model_Name`, `Total_Quantity`, `Vendor_ID`) VALUES (7789297, 'Joy Tamron', '407', 1004);
INSERT INTO `Delivery_System`.`Product_Model` (`Model_Number`, `Prod_Model_Name`, `Total_Quantity`, `Vendor_ID`) VALUES (7789298, 'Tip Aplam', '538', 1005);
INSERT INTO `Delivery_System`.`Product_Model` (`Model_Number`, `Prod_Model_Name`, `Total_Quantity`, `Vendor_ID`) VALUES (7789299, 'Biotam', '288', 1027);
INSERT INTO `Delivery_System`.`Product_Model` (`Model_Number`, `Prod_Model_Name`, `Total_Quantity`, `Vendor_ID`) VALUES (7789300, 'Yen shoi zoo', '734', 1026);

COMMIT;


-- -----------------------------------------------------
-- Data for table `Delivery_System`.`Product_Unit`
-- -----------------------------------------------------
START TRANSACTION;
USE `Delivery_System`;
INSERT INTO `Delivery_System`.`Product_Unit` (`Serial_No`, `Product_UnitPrice`, `Color`, `Size`, `Model_Number`) VALUES (484781, 2324, 'blue', '14.5in', 7789201);
INSERT INTO `Delivery_System`.`Product_Unit` (`Serial_No`, `Product_UnitPrice`, `Color`, `Size`, `Model_Number`) VALUES (484782, 3325, 'orange', '14.5in', 7789202);
INSERT INTO `Delivery_System`.`Product_Unit` (`Serial_No`, `Product_UnitPrice`, `Color`, `Size`, `Model_Number`) VALUES (484783, 1883, 'yellow', '14.5in', 7789203);
INSERT INTO `Delivery_System`.`Product_Unit` (`Serial_No`, `Product_UnitPrice`, `Color`, `Size`, `Model_Number`) VALUES (484784, 470, 'yellow', 'Small', 7789204);
INSERT INTO `Delivery_System`.`Product_Unit` (`Serial_No`, `Product_UnitPrice`, `Color`, `Size`, `Model_Number`) VALUES (484785, 5132, 'blue', '14.5in', 7789205);
INSERT INTO `Delivery_System`.`Product_Unit` (`Serial_No`, `Product_UnitPrice`, `Color`, `Size`, `Model_Number`) VALUES (484786, 5340, 'yellow', 'Small', 7789206);
INSERT INTO `Delivery_System`.`Product_Unit` (`Serial_No`, `Product_UnitPrice`, `Color`, `Size`, `Model_Number`) VALUES (484787, 4433, 'indigo', '14.5in', 7789207);
INSERT INTO `Delivery_System`.`Product_Unit` (`Serial_No`, `Product_UnitPrice`, `Color`, `Size`, `Model_Number`) VALUES (484788, 3497, 'green', 'Large', 7789208);
INSERT INTO `Delivery_System`.`Product_Unit` (`Serial_No`, `Product_UnitPrice`, `Color`, `Size`, `Model_Number`) VALUES (484789, 4288, 'indigo', 'Small', 7789209);
INSERT INTO `Delivery_System`.`Product_Unit` (`Serial_No`, `Product_UnitPrice`, `Color`, `Size`, `Model_Number`) VALUES (484790, 4685, 'violet', 'Large', 7789210);
INSERT INTO `Delivery_System`.`Product_Unit` (`Serial_No`, `Product_UnitPrice`, `Color`, `Size`, `Model_Number`) VALUES (484791, 2688, 'green', 'Large', 7789211);
INSERT INTO `Delivery_System`.`Product_Unit` (`Serial_No`, `Product_UnitPrice`, `Color`, `Size`, `Model_Number`) VALUES (484792, 995, 'violet', 'Medium', 7789212);
INSERT INTO `Delivery_System`.`Product_Unit` (`Serial_No`, `Product_UnitPrice`, `Color`, `Size`, `Model_Number`) VALUES (484793, 789, 'indigo', 'Large', 7789213);
INSERT INTO `Delivery_System`.`Product_Unit` (`Serial_No`, `Product_UnitPrice`, `Color`, `Size`, `Model_Number`) VALUES (484794, 400, 'orange', 'Large', 7789214);
INSERT INTO `Delivery_System`.`Product_Unit` (`Serial_No`, `Product_UnitPrice`, `Color`, `Size`, `Model_Number`) VALUES (484795, 239, 'indigo', 'Small', 7789215);
INSERT INTO `Delivery_System`.`Product_Unit` (`Serial_No`, `Product_UnitPrice`, `Color`, `Size`, `Model_Number`) VALUES (484796, 4878, 'red', 'Medium', 7789216);
INSERT INTO `Delivery_System`.`Product_Unit` (`Serial_No`, `Product_UnitPrice`, `Color`, `Size`, `Model_Number`) VALUES (484797, 5032, 'yellow', '14.5in', 7789217);
INSERT INTO `Delivery_System`.`Product_Unit` (`Serial_No`, `Product_UnitPrice`, `Color`, `Size`, `Model_Number`) VALUES (484798, 5205, 'indigo', 'Small', 7789218);
INSERT INTO `Delivery_System`.`Product_Unit` (`Serial_No`, `Product_UnitPrice`, `Color`, `Size`, `Model_Number`) VALUES (484799, 3315, 'violet', '14.5in', 7789219);
INSERT INTO `Delivery_System`.`Product_Unit` (`Serial_No`, `Product_UnitPrice`, `Color`, `Size`, `Model_Number`) VALUES (484800, 673, 'green', '14.5in', 7789220);
INSERT INTO `Delivery_System`.`Product_Unit` (`Serial_No`, `Product_UnitPrice`, `Color`, `Size`, `Model_Number`) VALUES (484801, 5134, 'yellow', '13.4in', 7789221);
INSERT INTO `Delivery_System`.`Product_Unit` (`Serial_No`, `Product_UnitPrice`, `Color`, `Size`, `Model_Number`) VALUES (484802, 2606, 'red', '13.4in', 7789222);
INSERT INTO `Delivery_System`.`Product_Unit` (`Serial_No`, `Product_UnitPrice`, `Color`, `Size`, `Model_Number`) VALUES (484803, 2944, 'red', '13.4in', 7789223);
INSERT INTO `Delivery_System`.`Product_Unit` (`Serial_No`, `Product_UnitPrice`, `Color`, `Size`, `Model_Number`) VALUES (484804, 2754, 'green', 'Small', 7789224);
INSERT INTO `Delivery_System`.`Product_Unit` (`Serial_No`, `Product_UnitPrice`, `Color`, `Size`, `Model_Number`) VALUES (484805, 512, 'red', '13.4in', 7789225);
INSERT INTO `Delivery_System`.`Product_Unit` (`Serial_No`, `Product_UnitPrice`, `Color`, `Size`, `Model_Number`) VALUES (484806, 4780, 'indigo', 'Medium', 7789226);
INSERT INTO `Delivery_System`.`Product_Unit` (`Serial_No`, `Product_UnitPrice`, `Color`, `Size`, `Model_Number`) VALUES (484807, 790, 'blue', 'Large', 7789227);
INSERT INTO `Delivery_System`.`Product_Unit` (`Serial_No`, `Product_UnitPrice`, `Color`, `Size`, `Model_Number`) VALUES (484808, 2370, 'red', 'Large', 7789228);
INSERT INTO `Delivery_System`.`Product_Unit` (`Serial_No`, `Product_UnitPrice`, `Color`, `Size`, `Model_Number`) VALUES (484809, 2551, 'orange', '13.4in', 7789229);
INSERT INTO `Delivery_System`.`Product_Unit` (`Serial_No`, `Product_UnitPrice`, `Color`, `Size`, `Model_Number`) VALUES (484810, 2694, 'green', '13.4in', 7789230);
INSERT INTO `Delivery_System`.`Product_Unit` (`Serial_No`, `Product_UnitPrice`, `Color`, `Size`, `Model_Number`) VALUES (484811, 4896, 'yellow', '13.4in', 7789231);
INSERT INTO `Delivery_System`.`Product_Unit` (`Serial_No`, `Product_UnitPrice`, `Color`, `Size`, `Model_Number`) VALUES (484812, 3144, 'red', 'Medium', 7789232);
INSERT INTO `Delivery_System`.`Product_Unit` (`Serial_No`, `Product_UnitPrice`, `Color`, `Size`, `Model_Number`) VALUES (484813, 4198, 'red', '13.4in', 7789233);
INSERT INTO `Delivery_System`.`Product_Unit` (`Serial_No`, `Product_UnitPrice`, `Color`, `Size`, `Model_Number`) VALUES (484814, 424, 'red', '14.5in', 7789234);
INSERT INTO `Delivery_System`.`Product_Unit` (`Serial_No`, `Product_UnitPrice`, `Color`, `Size`, `Model_Number`) VALUES (484815, 4889, 'yellow', '13.4in', 7789235);
INSERT INTO `Delivery_System`.`Product_Unit` (`Serial_No`, `Product_UnitPrice`, `Color`, `Size`, `Model_Number`) VALUES (484816, 3032, 'violet', 'Small', 7789236);
INSERT INTO `Delivery_System`.`Product_Unit` (`Serial_No`, `Product_UnitPrice`, `Color`, `Size`, `Model_Number`) VALUES (484817, 1787, 'yellow', '14.5in', 7789237);
INSERT INTO `Delivery_System`.`Product_Unit` (`Serial_No`, `Product_UnitPrice`, `Color`, `Size`, `Model_Number`) VALUES (484818, 2850, 'green', 'Small', 7789238);
INSERT INTO `Delivery_System`.`Product_Unit` (`Serial_No`, `Product_UnitPrice`, `Color`, `Size`, `Model_Number`) VALUES (484819, 1615, 'red', '13.4in', 7789239);
INSERT INTO `Delivery_System`.`Product_Unit` (`Serial_No`, `Product_UnitPrice`, `Color`, `Size`, `Model_Number`) VALUES (484820, 479, 'green', 'Medium', 7789240);
INSERT INTO `Delivery_System`.`Product_Unit` (`Serial_No`, `Product_UnitPrice`, `Color`, `Size`, `Model_Number`) VALUES (484821, 4431, 'violet', 'Small', 7789241);
INSERT INTO `Delivery_System`.`Product_Unit` (`Serial_No`, `Product_UnitPrice`, `Color`, `Size`, `Model_Number`) VALUES (484822, 4663, 'red', 'Large', 7789242);
INSERT INTO `Delivery_System`.`Product_Unit` (`Serial_No`, `Product_UnitPrice`, `Color`, `Size`, `Model_Number`) VALUES (484823, 4798, 'red', 'Large', 7789243);
INSERT INTO `Delivery_System`.`Product_Unit` (`Serial_No`, `Product_UnitPrice`, `Color`, `Size`, `Model_Number`) VALUES (484824, 1729, 'yellow', 'Large', 7789244);
INSERT INTO `Delivery_System`.`Product_Unit` (`Serial_No`, `Product_UnitPrice`, `Color`, `Size`, `Model_Number`) VALUES (484825, 4088, 'violet', 'Small', 7789245);
INSERT INTO `Delivery_System`.`Product_Unit` (`Serial_No`, `Product_UnitPrice`, `Color`, `Size`, `Model_Number`) VALUES (484826, 453, 'red', 'Small', 7789246);
INSERT INTO `Delivery_System`.`Product_Unit` (`Serial_No`, `Product_UnitPrice`, `Color`, `Size`, `Model_Number`) VALUES (484827, 779, 'red', 'Medium', 7789247);
INSERT INTO `Delivery_System`.`Product_Unit` (`Serial_No`, `Product_UnitPrice`, `Color`, `Size`, `Model_Number`) VALUES (484828, 951, 'blue', '13.4in', 7789248);
INSERT INTO `Delivery_System`.`Product_Unit` (`Serial_No`, `Product_UnitPrice`, `Color`, `Size`, `Model_Number`) VALUES (484829, 2930, 'orange', 'Large', 7789249);
INSERT INTO `Delivery_System`.`Product_Unit` (`Serial_No`, `Product_UnitPrice`, `Color`, `Size`, `Model_Number`) VALUES (484830, 645, 'red', 'Medium', 7789250);
INSERT INTO `Delivery_System`.`Product_Unit` (`Serial_No`, `Product_UnitPrice`, `Color`, `Size`, `Model_Number`) VALUES (484831, 1785, 'indigo', 'Medium', 7789251);
INSERT INTO `Delivery_System`.`Product_Unit` (`Serial_No`, `Product_UnitPrice`, `Color`, `Size`, `Model_Number`) VALUES (484832, 4653, 'orange', 'Medium', 7789252);
INSERT INTO `Delivery_System`.`Product_Unit` (`Serial_No`, `Product_UnitPrice`, `Color`, `Size`, `Model_Number`) VALUES (484833, 4652, 'green', '14.5in', 7789253);
INSERT INTO `Delivery_System`.`Product_Unit` (`Serial_No`, `Product_UnitPrice`, `Color`, `Size`, `Model_Number`) VALUES (484834, 4974, 'indigo', '13.4in', 7789254);
INSERT INTO `Delivery_System`.`Product_Unit` (`Serial_No`, `Product_UnitPrice`, `Color`, `Size`, `Model_Number`) VALUES (484835, 3298, 'violet', '14.5in', 7789255);
INSERT INTO `Delivery_System`.`Product_Unit` (`Serial_No`, `Product_UnitPrice`, `Color`, `Size`, `Model_Number`) VALUES (484836, 4951, 'green', '13.4in', 7789256);
INSERT INTO `Delivery_System`.`Product_Unit` (`Serial_No`, `Product_UnitPrice`, `Color`, `Size`, `Model_Number`) VALUES (484837, 1070, 'orange', '13.4in', 7789257);
INSERT INTO `Delivery_System`.`Product_Unit` (`Serial_No`, `Product_UnitPrice`, `Color`, `Size`, `Model_Number`) VALUES (484838, 5359, 'red', 'Small', 7789258);
INSERT INTO `Delivery_System`.`Product_Unit` (`Serial_No`, `Product_UnitPrice`, `Color`, `Size`, `Model_Number`) VALUES (484839, 2020, 'indigo', 'Medium', 7789259);
INSERT INTO `Delivery_System`.`Product_Unit` (`Serial_No`, `Product_UnitPrice`, `Color`, `Size`, `Model_Number`) VALUES (484840, 398, 'blue', 'Large', 7789260);
INSERT INTO `Delivery_System`.`Product_Unit` (`Serial_No`, `Product_UnitPrice`, `Color`, `Size`, `Model_Number`) VALUES (484841, 2144, 'yellow', 'Large', 7789261);
INSERT INTO `Delivery_System`.`Product_Unit` (`Serial_No`, `Product_UnitPrice`, `Color`, `Size`, `Model_Number`) VALUES (484842, 4051, 'blue', 'Large', 7789262);
INSERT INTO `Delivery_System`.`Product_Unit` (`Serial_No`, `Product_UnitPrice`, `Color`, `Size`, `Model_Number`) VALUES (484843, 4451, 'orange', 'Small', 7789263);
INSERT INTO `Delivery_System`.`Product_Unit` (`Serial_No`, `Product_UnitPrice`, `Color`, `Size`, `Model_Number`) VALUES (484844, 5290, 'orange', '13.4in', 7789264);
INSERT INTO `Delivery_System`.`Product_Unit` (`Serial_No`, `Product_UnitPrice`, `Color`, `Size`, `Model_Number`) VALUES (484845, 3059, 'blue', '13.4in', 7789265);
INSERT INTO `Delivery_System`.`Product_Unit` (`Serial_No`, `Product_UnitPrice`, `Color`, `Size`, `Model_Number`) VALUES (484846, 4018, 'indigo', '14.5in', 7789266);
INSERT INTO `Delivery_System`.`Product_Unit` (`Serial_No`, `Product_UnitPrice`, `Color`, `Size`, `Model_Number`) VALUES (484847, 4403, 'yellow', 'Large', 7789267);
INSERT INTO `Delivery_System`.`Product_Unit` (`Serial_No`, `Product_UnitPrice`, `Color`, `Size`, `Model_Number`) VALUES (484848, 4785, 'indigo', '13.4in', 7789268);
INSERT INTO `Delivery_System`.`Product_Unit` (`Serial_No`, `Product_UnitPrice`, `Color`, `Size`, `Model_Number`) VALUES (484849, 614, 'violet', 'Medium', 7789269);
INSERT INTO `Delivery_System`.`Product_Unit` (`Serial_No`, `Product_UnitPrice`, `Color`, `Size`, `Model_Number`) VALUES (484850, 4236, 'green', 'Medium', 7789270);
INSERT INTO `Delivery_System`.`Product_Unit` (`Serial_No`, `Product_UnitPrice`, `Color`, `Size`, `Model_Number`) VALUES (484851, 5260, 'blue', '13.4in', 7789271);
INSERT INTO `Delivery_System`.`Product_Unit` (`Serial_No`, `Product_UnitPrice`, `Color`, `Size`, `Model_Number`) VALUES (484852, 325, 'green', 'Medium', 7789272);
INSERT INTO `Delivery_System`.`Product_Unit` (`Serial_No`, `Product_UnitPrice`, `Color`, `Size`, `Model_Number`) VALUES (484853, 2656, 'green', '14.5in', 7789273);
INSERT INTO `Delivery_System`.`Product_Unit` (`Serial_No`, `Product_UnitPrice`, `Color`, `Size`, `Model_Number`) VALUES (484854, 1505, 'violet', 'Large', 7789274);
INSERT INTO `Delivery_System`.`Product_Unit` (`Serial_No`, `Product_UnitPrice`, `Color`, `Size`, `Model_Number`) VALUES (484855, 1872, 'violet', '14.5in', 7789275);
INSERT INTO `Delivery_System`.`Product_Unit` (`Serial_No`, `Product_UnitPrice`, `Color`, `Size`, `Model_Number`) VALUES (484856, 1128, 'indigo', 'Large', 7789276);
INSERT INTO `Delivery_System`.`Product_Unit` (`Serial_No`, `Product_UnitPrice`, `Color`, `Size`, `Model_Number`) VALUES (484857, 4440, 'orange', '14.5in', 7789277);
INSERT INTO `Delivery_System`.`Product_Unit` (`Serial_No`, `Product_UnitPrice`, `Color`, `Size`, `Model_Number`) VALUES (484858, 865, 'green', '14.5in', 7789278);
INSERT INTO `Delivery_System`.`Product_Unit` (`Serial_No`, `Product_UnitPrice`, `Color`, `Size`, `Model_Number`) VALUES (484859, 160, 'orange', '14.5in', 7789279);
INSERT INTO `Delivery_System`.`Product_Unit` (`Serial_No`, `Product_UnitPrice`, `Color`, `Size`, `Model_Number`) VALUES (484860, 3327, 'blue', '14.5in', 7789280);
INSERT INTO `Delivery_System`.`Product_Unit` (`Serial_No`, `Product_UnitPrice`, `Color`, `Size`, `Model_Number`) VALUES (484861, 4604, 'green', 'Small', 7789281);
INSERT INTO `Delivery_System`.`Product_Unit` (`Serial_No`, `Product_UnitPrice`, `Color`, `Size`, `Model_Number`) VALUES (484862, 1305, 'blue', 'Large', 7789282);
INSERT INTO `Delivery_System`.`Product_Unit` (`Serial_No`, `Product_UnitPrice`, `Color`, `Size`, `Model_Number`) VALUES (484863, 1963, 'green', '13.4in', 7789283);
INSERT INTO `Delivery_System`.`Product_Unit` (`Serial_No`, `Product_UnitPrice`, `Color`, `Size`, `Model_Number`) VALUES (484864, 172, 'red', 'Small', 7789284);
INSERT INTO `Delivery_System`.`Product_Unit` (`Serial_No`, `Product_UnitPrice`, `Color`, `Size`, `Model_Number`) VALUES (484865, 4682, 'orange', '14.5in', 7789285);
INSERT INTO `Delivery_System`.`Product_Unit` (`Serial_No`, `Product_UnitPrice`, `Color`, `Size`, `Model_Number`) VALUES (484866, 968, 'red', 'Large', 7789286);
INSERT INTO `Delivery_System`.`Product_Unit` (`Serial_No`, `Product_UnitPrice`, `Color`, `Size`, `Model_Number`) VALUES (484867, 592, 'indigo', 'Medium', 7789287);
INSERT INTO `Delivery_System`.`Product_Unit` (`Serial_No`, `Product_UnitPrice`, `Color`, `Size`, `Model_Number`) VALUES (484868, 1028, 'red', '13.4in', 7789288);
INSERT INTO `Delivery_System`.`Product_Unit` (`Serial_No`, `Product_UnitPrice`, `Color`, `Size`, `Model_Number`) VALUES (484869, 638, 'red', '14.5in', 7789289);
INSERT INTO `Delivery_System`.`Product_Unit` (`Serial_No`, `Product_UnitPrice`, `Color`, `Size`, `Model_Number`) VALUES (484870, 1944, 'yellow', '13.4in', 7789290);
INSERT INTO `Delivery_System`.`Product_Unit` (`Serial_No`, `Product_UnitPrice`, `Color`, `Size`, `Model_Number`) VALUES (484871, 4049, 'violet', '13.4in', 7789291);
INSERT INTO `Delivery_System`.`Product_Unit` (`Serial_No`, `Product_UnitPrice`, `Color`, `Size`, `Model_Number`) VALUES (484872, 4056, 'violet', 'Large', 7789292);
INSERT INTO `Delivery_System`.`Product_Unit` (`Serial_No`, `Product_UnitPrice`, `Color`, `Size`, `Model_Number`) VALUES (484873, 2897, 'indigo', '14.5in', 7789293);
INSERT INTO `Delivery_System`.`Product_Unit` (`Serial_No`, `Product_UnitPrice`, `Color`, `Size`, `Model_Number`) VALUES (484874, 113, 'green', '14.5in', 7789294);
INSERT INTO `Delivery_System`.`Product_Unit` (`Serial_No`, `Product_UnitPrice`, `Color`, `Size`, `Model_Number`) VALUES (484875, 4661, 'orange', 'Large', 7789295);
INSERT INTO `Delivery_System`.`Product_Unit` (`Serial_No`, `Product_UnitPrice`, `Color`, `Size`, `Model_Number`) VALUES (484876, 2529, 'green', '14.5in', 7789296);
INSERT INTO `Delivery_System`.`Product_Unit` (`Serial_No`, `Product_UnitPrice`, `Color`, `Size`, `Model_Number`) VALUES (484877, 3738, 'orange', 'Small', 7789297);
INSERT INTO `Delivery_System`.`Product_Unit` (`Serial_No`, `Product_UnitPrice`, `Color`, `Size`, `Model_Number`) VALUES (484878, 2322, 'orange', 'Medium', 7789298);
INSERT INTO `Delivery_System`.`Product_Unit` (`Serial_No`, `Product_UnitPrice`, `Color`, `Size`, `Model_Number`) VALUES (484879, 4647, 'orange', 'Large', 7789299);
INSERT INTO `Delivery_System`.`Product_Unit` (`Serial_No`, `Product_UnitPrice`, `Color`, `Size`, `Model_Number`) VALUES (484880, 5233, 'violet', '13.4in', 7789300);

COMMIT;


-- -----------------------------------------------------
-- Data for table `Delivery_System`.`Department`
-- -----------------------------------------------------
START TRANSACTION;
USE `Delivery_System`;
INSERT INTO `Delivery_System`.`Department` (`Department_ID`, `Department_Name`) VALUES (101, 'Electronics');
INSERT INTO `Delivery_System`.`Department` (`Department_ID`, `Department_Name`) VALUES (102, 'Clothing');
INSERT INTO `Delivery_System`.`Department` (`Department_ID`, `Department_Name`) VALUES (103, 'Shoes');
INSERT INTO `Delivery_System`.`Department` (`Department_ID`, `Department_Name`) VALUES (104, 'Bags');
INSERT INTO `Delivery_System`.`Department` (`Department_ID`, `Department_Name`) VALUES (105, 'Accessories');
INSERT INTO `Delivery_System`.`Department` (`Department_ID`, `Department_Name`) VALUES (106, 'Health and Beauty');
INSERT INTO `Delivery_System`.`Department` (`Department_ID`, `Department_Name`) VALUES (107, 'Sports');

COMMIT;


-- -----------------------------------------------------
-- Data for table `Delivery_System`.`Category`
-- -----------------------------------------------------
START TRANSACTION;
USE `Delivery_System`;
INSERT INTO `Delivery_System`.`Category` (`Category_ID`, `Category_Name`, `Department_ID`) VALUES (10001, 'Phones', 101);
INSERT INTO `Delivery_System`.`Category` (`Category_ID`, `Category_Name`, `Department_ID`) VALUES (10002, 'Laptops', 101);
INSERT INTO `Delivery_System`.`Category` (`Category_ID`, `Category_Name`, `Department_ID`) VALUES (10003, 'Tablets', 101);
INSERT INTO `Delivery_System`.`Category` (`Category_ID`, `Category_Name`, `Department_ID`) VALUES (10004, 'Pants', 102);
INSERT INTO `Delivery_System`.`Category` (`Category_ID`, `Category_Name`, `Department_ID`) VALUES (10005, 'Shirts', 102);
INSERT INTO `Delivery_System`.`Category` (`Category_ID`, `Category_Name`, `Department_ID`) VALUES (10006, 'Heels', 103);
INSERT INTO `Delivery_System`.`Category` (`Category_ID`, `Category_Name`, `Department_ID`) VALUES (10007, 'Flats', 103);
INSERT INTO `Delivery_System`.`Category` (`Category_ID`, `Category_Name`, `Department_ID`) VALUES (10008, 'Watches', 105);
INSERT INTO `Delivery_System`.`Category` (`Category_ID`, `Category_Name`, `Department_ID`) VALUES (10009, 'Body Sprays', 106);
INSERT INTO `Delivery_System`.`Category` (`Category_ID`, `Category_Name`, `Department_ID`) VALUES (10010, 'Bags', 104);
INSERT INTO `Delivery_System`.`Category` (`Category_ID`, `Category_Name`, `Department_ID`) VALUES (10011, 'Lipsticks', 106);
INSERT INTO `Delivery_System`.`Category` (`Category_ID`, `Category_Name`, `Department_ID`) VALUES (10012, 'Eye Shadow', 106);

COMMIT;


-- -----------------------------------------------------
-- Data for table `Delivery_System`.`Warehouse`
-- -----------------------------------------------------
START TRANSACTION;
USE `Delivery_System`;
INSERT INTO `Delivery_System`.`Warehouse` (`warehouse_ID`, `Street_1`, `Zip_Code`, `Vendor_ID`) VALUES (1, '893-7827 Vehicula Rd.', 12111, 1001);
INSERT INTO `Delivery_System`.`Warehouse` (`warehouse_ID`, `Street_1`, `Zip_Code`, `Vendor_ID`) VALUES (2, '571-3769 Ut St.', 12131, 1002);
INSERT INTO `Delivery_System`.`Warehouse` (`warehouse_ID`, `Street_1`, `Zip_Code`, `Vendor_ID`) VALUES (3, '912-7167 Nisi. Rd.', 12120, 1003);
INSERT INTO `Delivery_System`.`Warehouse` (`warehouse_ID`, `Street_1`, `Zip_Code`, `Vendor_ID`) VALUES (4, 'P.O. Box 409, 237 Nisi St.', 12189, 1004);
INSERT INTO `Delivery_System`.`Warehouse` (`warehouse_ID`, `Street_1`, `Zip_Code`, `Vendor_ID`) VALUES (5, 'Ap #813-5311 Diam Rd.', 17854, 1005);
INSERT INTO `Delivery_System`.`Warehouse` (`warehouse_ID`, `Street_1`, `Zip_Code`, `Vendor_ID`) VALUES (6, '451-3777 Rutrum Road', 17845, 1006);
INSERT INTO `Delivery_System`.`Warehouse` (`warehouse_ID`, `Street_1`, `Zip_Code`, `Vendor_ID`) VALUES (7, 'P.O. Box 145, 9656 Dictum Rd.', 17842, 1007);
INSERT INTO `Delivery_System`.`Warehouse` (`warehouse_ID`, `Street_1`, `Zip_Code`, `Vendor_ID`) VALUES (8, '3439 Suspendisse Rd.', 17830, 1008);
INSERT INTO `Delivery_System`.`Warehouse` (`warehouse_ID`, `Street_1`, `Zip_Code`, `Vendor_ID`) VALUES (9, '580-3078 Interdum. Avenue', 25681, 1009);
INSERT INTO `Delivery_System`.`Warehouse` (`warehouse_ID`, `Street_1`, `Zip_Code`, `Vendor_ID`) VALUES (10, 'P.O. Box 160, 9624 Non, Rd.', 25654, 1010);
INSERT INTO `Delivery_System`.`Warehouse` (`warehouse_ID`, `Street_1`, `Zip_Code`, `Vendor_ID`) VALUES (11, 'Ap #443-914 Arcu Rd.', 25664, 1011);
INSERT INTO `Delivery_System`.`Warehouse` (`warehouse_ID`, `Street_1`, `Zip_Code`, `Vendor_ID`) VALUES (12, 'P.O. Box 432, 1982 Ante Road', 25648, 1012);
INSERT INTO `Delivery_System`.`Warehouse` (`warehouse_ID`, `Street_1`, `Zip_Code`, `Vendor_ID`) VALUES (13, '610-6340 Nisl. Street', 31822, 1013);
INSERT INTO `Delivery_System`.`Warehouse` (`warehouse_ID`, `Street_1`, `Zip_Code`, `Vendor_ID`) VALUES (14, '2427 Nec, Av.', 31874, 1014);
INSERT INTO `Delivery_System`.`Warehouse` (`warehouse_ID`, `Street_1`, `Zip_Code`, `Vendor_ID`) VALUES (15, '4140 Fringilla Rd.', 31849, 1015);
INSERT INTO `Delivery_System`.`Warehouse` (`warehouse_ID`, `Street_1`, `Zip_Code`, `Vendor_ID`) VALUES (16, 'P.O. Box 200, 4032 Maecenas Ave', 31834, 1016);
INSERT INTO `Delivery_System`.`Warehouse` (`warehouse_ID`, `Street_1`, `Zip_Code`, `Vendor_ID`) VALUES (17, 'Ap #514-8047 Penatibus Street', 48344, 1017);
INSERT INTO `Delivery_System`.`Warehouse` (`warehouse_ID`, `Street_1`, `Zip_Code`, `Vendor_ID`) VALUES (18, '502 Consectetuer Road', 48314, 1018);
INSERT INTO `Delivery_System`.`Warehouse` (`warehouse_ID`, `Street_1`, `Zip_Code`, `Vendor_ID`) VALUES (19, '9339 Nulla Avenue', 48350, 1019);
INSERT INTO `Delivery_System`.`Warehouse` (`warehouse_ID`, `Street_1`, `Zip_Code`, `Vendor_ID`) VALUES (20, '494-6527 Fringilla Ave', 53764, 1020);
INSERT INTO `Delivery_System`.`Warehouse` (`warehouse_ID`, `Street_1`, `Zip_Code`, `Vendor_ID`) VALUES (21, 'Ap #190-2507 Dis Avenue', 53790, 1021);
INSERT INTO `Delivery_System`.`Warehouse` (`warehouse_ID`, `Street_1`, `Zip_Code`, `Vendor_ID`) VALUES (22, 'Ap #800-8820 Maecenas Rd.', 53735, 1022);
INSERT INTO `Delivery_System`.`Warehouse` (`warehouse_ID`, `Street_1`, `Zip_Code`, `Vendor_ID`) VALUES (23, 'Ap #497-136 Elementum, St.', 53740, 1023);
INSERT INTO `Delivery_System`.`Warehouse` (`warehouse_ID`, `Street_1`, `Zip_Code`, `Vendor_ID`) VALUES (24, 'Ap #518-9807 Et, Ave', 12391, 1024);
INSERT INTO `Delivery_System`.`Warehouse` (`warehouse_ID`, `Street_1`, `Zip_Code`, `Vendor_ID`) VALUES (25, 'P.O. Box 741, 9670 Enim. St.', 12393, 1025);
INSERT INTO `Delivery_System`.`Warehouse` (`warehouse_ID`, `Street_1`, `Zip_Code`, `Vendor_ID`) VALUES (26, 'P.O. Box 171, 1171 Purus Rd.', 12389, 1026);
INSERT INTO `Delivery_System`.`Warehouse` (`warehouse_ID`, `Street_1`, `Zip_Code`, `Vendor_ID`) VALUES (27, '637-7727 Penatibus St.', 20898, 1027);
INSERT INTO `Delivery_System`.`Warehouse` (`warehouse_ID`, `Street_1`, `Zip_Code`, `Vendor_ID`) VALUES (28, '807-1505 Sit Avenue', 20875, 1028);
INSERT INTO `Delivery_System`.`Warehouse` (`warehouse_ID`, `Street_1`, `Zip_Code`, `Vendor_ID`) VALUES (29, 'P.O. Box 253, 6880 Nonummy Road', 20885, 1029);
INSERT INTO `Delivery_System`.`Warehouse` (`warehouse_ID`, `Street_1`, `Zip_Code`, `Vendor_ID`) VALUES (30, 'Ap #761-5085 Sit Street', 45491, 1030);
INSERT INTO `Delivery_System`.`Warehouse` (`warehouse_ID`, `Street_1`, `Zip_Code`, `Vendor_ID`) VALUES (31, 'P.O. Box 771, 2456 Magna. St.', 45425, 1031);
INSERT INTO `Delivery_System`.`Warehouse` (`warehouse_ID`, `Street_1`, `Zip_Code`, `Vendor_ID`) VALUES (32, '5724 Consectetuer Road', 45429, 1031);
INSERT INTO `Delivery_System`.`Warehouse` (`warehouse_ID`, `Street_1`, `Zip_Code`, `Vendor_ID`) VALUES (33, '8103 Gravida Ave', 45493, 1031);
INSERT INTO `Delivery_System`.`Warehouse` (`warehouse_ID`, `Street_1`, `Zip_Code`, `Vendor_ID`) VALUES (34, 'P.O. Box 788, 9955 At Street', 28733, 1031);
INSERT INTO `Delivery_System`.`Warehouse` (`warehouse_ID`, `Street_1`, `Zip_Code`, `Vendor_ID`) VALUES (35, '3614 Felis. Rd.', 28762, 1031);
INSERT INTO `Delivery_System`.`Warehouse` (`warehouse_ID`, `Street_1`, `Zip_Code`, `Vendor_ID`) VALUES (36, '1289 Cras Avenue', 28763, 1031);
INSERT INTO `Delivery_System`.`Warehouse` (`warehouse_ID`, `Street_1`, `Zip_Code`, `Vendor_ID`) VALUES (37, '611-4679 Egestas, Rd.', 28768, 1031);
INSERT INTO `Delivery_System`.`Warehouse` (`warehouse_ID`, `Street_1`, `Zip_Code`, `Vendor_ID`) VALUES (38, 'P.O. Box 225, 1172 Nullam Rd.', 76588, 1031);
INSERT INTO `Delivery_System`.`Warehouse` (`warehouse_ID`, `Street_1`, `Zip_Code`, `Vendor_ID`) VALUES (39, '327-816 Nulla. Ave', 76546, 1031);
INSERT INTO `Delivery_System`.`Warehouse` (`warehouse_ID`, `Street_1`, `Zip_Code`, `Vendor_ID`) VALUES (40, 'Ap #536-935 Donec Street', 76584, 1031);
INSERT INTO `Delivery_System`.`Warehouse` (`warehouse_ID`, `Street_1`, `Zip_Code`, `Vendor_ID`) VALUES (41, '2790 Diam. Ave', 67823, 1031);
INSERT INTO `Delivery_System`.`Warehouse` (`warehouse_ID`, `Street_1`, `Zip_Code`, `Vendor_ID`) VALUES (42, 'Ap #328-9700 Pellentesque Ave', 67866, 1031);
INSERT INTO `Delivery_System`.`Warehouse` (`warehouse_ID`, `Street_1`, `Zip_Code`, `Vendor_ID`) VALUES (43, '8692 Ullamcorper. St.', 67881, 1031);
INSERT INTO `Delivery_System`.`Warehouse` (`warehouse_ID`, `Street_1`, `Zip_Code`, `Vendor_ID`) VALUES (44, 'P.O. Box 810, 7923 Eget, Road', 67845, 1031);
INSERT INTO `Delivery_System`.`Warehouse` (`warehouse_ID`, `Street_1`, `Zip_Code`, `Vendor_ID`) VALUES (45, '407-4919 Risus. Street', 54324, 1031);
INSERT INTO `Delivery_System`.`Warehouse` (`warehouse_ID`, `Street_1`, `Zip_Code`, `Vendor_ID`) VALUES (46, 'P.O. Box 981, 549 Augue Rd.', 54330, 1031);
INSERT INTO `Delivery_System`.`Warehouse` (`warehouse_ID`, `Street_1`, `Zip_Code`, `Vendor_ID`) VALUES (47, '586-7679 Ipsum St.', 54360, 1031);
INSERT INTO `Delivery_System`.`Warehouse` (`warehouse_ID`, `Street_1`, `Zip_Code`, `Vendor_ID`) VALUES (48, 'Ap #950-8150 Quisque Avenue', 61672, 1031);
INSERT INTO `Delivery_System`.`Warehouse` (`warehouse_ID`, `Street_1`, `Zip_Code`, `Vendor_ID`) VALUES (49, '167-3496 Quisque Street', 61699, 1031);
INSERT INTO `Delivery_System`.`Warehouse` (`warehouse_ID`, `Street_1`, `Zip_Code`, `Vendor_ID`) VALUES (50, '297-1194 Ultricies Av.', 61637, 1031);

COMMIT;


-- -----------------------------------------------------
-- Data for table `Delivery_System`.`Drone_Type`
-- -----------------------------------------------------
START TRANSACTION;
USE `Delivery_System`;
INSERT INTO `Delivery_System`.`Drone_Type` (`Drone_Type_ID`, `Drone_Weight`, `Drone_Capacity`, `Drone_Units`, `Battery_Desc`) VALUES ('A', 1, 5, 120, 48);
INSERT INTO `Delivery_System`.`Drone_Type` (`Drone_Type_ID`, `Drone_Weight`, `Drone_Capacity`, `Drone_Units`, `Battery_Desc`) VALUES ('B', 4, 20, 100, 72);
INSERT INTO `Delivery_System`.`Drone_Type` (`Drone_Type_ID`, `Drone_Weight`, `Drone_Capacity`, `Drone_Units`, `Battery_Desc`) VALUES ('C', 8, 35, 60, 96);
INSERT INTO `Delivery_System`.`Drone_Type` (`Drone_Type_ID`, `Drone_Weight`, `Drone_Capacity`, `Drone_Units`, `Battery_Desc`) VALUES ('D', 12, 50, 40, 120);
INSERT INTO `Delivery_System`.`Drone_Type` (`Drone_Type_ID`, `Drone_Weight`, `Drone_Capacity`, `Drone_Units`, `Battery_Desc`) VALUES ('E', 16, 65, 20, 144);

COMMIT;


-- -----------------------------------------------------
-- Data for table `Delivery_System`.`Drone_Details`
-- -----------------------------------------------------
START TRANSACTION;
USE `Delivery_System`;
INSERT INTO `Delivery_System`.`Drone_Details` (`Drone_ID`, `Drone_Status`, `warehouse_ID`, `Drone_Type_ID`) VALUES (1, 'Available', 34, 'A');
INSERT INTO `Delivery_System`.`Drone_Details` (`Drone_ID`, `Drone_Status`, `warehouse_ID`, `Drone_Type_ID`) VALUES (2, 'Available', 46, 'A');
INSERT INTO `Delivery_System`.`Drone_Details` (`Drone_ID`, `Drone_Status`, `warehouse_ID`, `Drone_Type_ID`) VALUES (3, 'Available', 31, 'A');
INSERT INTO `Delivery_System`.`Drone_Details` (`Drone_ID`, `Drone_Status`, `warehouse_ID`, `Drone_Type_ID`) VALUES (4, 'Available', 47, 'A');
INSERT INTO `Delivery_System`.`Drone_Details` (`Drone_ID`, `Drone_Status`, `warehouse_ID`, `Drone_Type_ID`) VALUES (5, 'Available', 34, 'A');
INSERT INTO `Delivery_System`.`Drone_Details` (`Drone_ID`, `Drone_Status`, `warehouse_ID`, `Drone_Type_ID`) VALUES (6, 'Available', 45, 'A');
INSERT INTO `Delivery_System`.`Drone_Details` (`Drone_ID`, `Drone_Status`, `warehouse_ID`, `Drone_Type_ID`) VALUES (7, 'Available', 40, 'A');
INSERT INTO `Delivery_System`.`Drone_Details` (`Drone_ID`, `Drone_Status`, `warehouse_ID`, `Drone_Type_ID`) VALUES (8, 'Available', 46, 'A');
INSERT INTO `Delivery_System`.`Drone_Details` (`Drone_ID`, `Drone_Status`, `warehouse_ID`, `Drone_Type_ID`) VALUES (9, 'Available', 43, 'A');
INSERT INTO `Delivery_System`.`Drone_Details` (`Drone_ID`, `Drone_Status`, `warehouse_ID`, `Drone_Type_ID`) VALUES (10, 'Available', 34, 'A');
INSERT INTO `Delivery_System`.`Drone_Details` (`Drone_ID`, `Drone_Status`, `warehouse_ID`, `Drone_Type_ID`) VALUES (11, 'Unavailable', 44, 'A');
INSERT INTO `Delivery_System`.`Drone_Details` (`Drone_ID`, `Drone_Status`, `warehouse_ID`, `Drone_Type_ID`) VALUES (12, 'Available', 37, 'A');
INSERT INTO `Delivery_System`.`Drone_Details` (`Drone_ID`, `Drone_Status`, `warehouse_ID`, `Drone_Type_ID`) VALUES (13, 'Available', 36, 'A');
INSERT INTO `Delivery_System`.`Drone_Details` (`Drone_ID`, `Drone_Status`, `warehouse_ID`, `Drone_Type_ID`) VALUES (14, 'Available', 34, 'A');
INSERT INTO `Delivery_System`.`Drone_Details` (`Drone_ID`, `Drone_Status`, `warehouse_ID`, `Drone_Type_ID`) VALUES (15, 'Available', 47, 'A');
INSERT INTO `Delivery_System`.`Drone_Details` (`Drone_ID`, `Drone_Status`, `warehouse_ID`, `Drone_Type_ID`) VALUES (16, 'Available', 39, 'A');
INSERT INTO `Delivery_System`.`Drone_Details` (`Drone_ID`, `Drone_Status`, `warehouse_ID`, `Drone_Type_ID`) VALUES (17, 'Available', 36, 'A');
INSERT INTO `Delivery_System`.`Drone_Details` (`Drone_ID`, `Drone_Status`, `warehouse_ID`, `Drone_Type_ID`) VALUES (18, 'Available', 48, 'A');
INSERT INTO `Delivery_System`.`Drone_Details` (`Drone_ID`, `Drone_Status`, `warehouse_ID`, `Drone_Type_ID`) VALUES (19, 'Available', 45, 'A');
INSERT INTO `Delivery_System`.`Drone_Details` (`Drone_ID`, `Drone_Status`, `warehouse_ID`, `Drone_Type_ID`) VALUES (20, 'Available', 37, 'A');
INSERT INTO `Delivery_System`.`Drone_Details` (`Drone_ID`, `Drone_Status`, `warehouse_ID`, `Drone_Type_ID`) VALUES (21, 'Available', 32, 'A');
INSERT INTO `Delivery_System`.`Drone_Details` (`Drone_ID`, `Drone_Status`, `warehouse_ID`, `Drone_Type_ID`) VALUES (22, 'Available', 48, 'A');
INSERT INTO `Delivery_System`.`Drone_Details` (`Drone_ID`, `Drone_Status`, `warehouse_ID`, `Drone_Type_ID`) VALUES (23, 'Available', 35, 'A');
INSERT INTO `Delivery_System`.`Drone_Details` (`Drone_ID`, `Drone_Status`, `warehouse_ID`, `Drone_Type_ID`) VALUES (24, 'Available', 41, 'A');
INSERT INTO `Delivery_System`.`Drone_Details` (`Drone_ID`, `Drone_Status`, `warehouse_ID`, `Drone_Type_ID`) VALUES (25, 'Available', 34, 'A');
INSERT INTO `Delivery_System`.`Drone_Details` (`Drone_ID`, `Drone_Status`, `warehouse_ID`, `Drone_Type_ID`) VALUES (26, 'Available', 46, 'A');
INSERT INTO `Delivery_System`.`Drone_Details` (`Drone_ID`, `Drone_Status`, `warehouse_ID`, `Drone_Type_ID`) VALUES (27, 'Available', 42, 'A');
INSERT INTO `Delivery_System`.`Drone_Details` (`Drone_ID`, `Drone_Status`, `warehouse_ID`, `Drone_Type_ID`) VALUES (28, 'Available', 37, 'A');
INSERT INTO `Delivery_System`.`Drone_Details` (`Drone_ID`, `Drone_Status`, `warehouse_ID`, `Drone_Type_ID`) VALUES (29, 'Available', 49, 'A');
INSERT INTO `Delivery_System`.`Drone_Details` (`Drone_ID`, `Drone_Status`, `warehouse_ID`, `Drone_Type_ID`) VALUES (30, 'Available', 47, 'A');
INSERT INTO `Delivery_System`.`Drone_Details` (`Drone_ID`, `Drone_Status`, `warehouse_ID`, `Drone_Type_ID`) VALUES (31, 'Available', 45, 'A');
INSERT INTO `Delivery_System`.`Drone_Details` (`Drone_ID`, `Drone_Status`, `warehouse_ID`, `Drone_Type_ID`) VALUES (32, 'Available', 32, 'A');
INSERT INTO `Delivery_System`.`Drone_Details` (`Drone_ID`, `Drone_Status`, `warehouse_ID`, `Drone_Type_ID`) VALUES (33, 'Available', 44, 'A');
INSERT INTO `Delivery_System`.`Drone_Details` (`Drone_ID`, `Drone_Status`, `warehouse_ID`, `Drone_Type_ID`) VALUES (34, 'Available', 41, 'A');
INSERT INTO `Delivery_System`.`Drone_Details` (`Drone_ID`, `Drone_Status`, `warehouse_ID`, `Drone_Type_ID`) VALUES (35, 'Available', 41, 'A');
INSERT INTO `Delivery_System`.`Drone_Details` (`Drone_ID`, `Drone_Status`, `warehouse_ID`, `Drone_Type_ID`) VALUES (36, 'Available', 45, 'A');
INSERT INTO `Delivery_System`.`Drone_Details` (`Drone_ID`, `Drone_Status`, `warehouse_ID`, `Drone_Type_ID`) VALUES (37, 'Available', 33, 'A');
INSERT INTO `Delivery_System`.`Drone_Details` (`Drone_ID`, `Drone_Status`, `warehouse_ID`, `Drone_Type_ID`) VALUES (38, 'Available', 33, 'A');
INSERT INTO `Delivery_System`.`Drone_Details` (`Drone_ID`, `Drone_Status`, `warehouse_ID`, `Drone_Type_ID`) VALUES (39, 'Available', 32, 'A');
INSERT INTO `Delivery_System`.`Drone_Details` (`Drone_ID`, `Drone_Status`, `warehouse_ID`, `Drone_Type_ID`) VALUES (40, 'Available', 41, 'A');
INSERT INTO `Delivery_System`.`Drone_Details` (`Drone_ID`, `Drone_Status`, `warehouse_ID`, `Drone_Type_ID`) VALUES (41, 'Available', 38, 'A');
INSERT INTO `Delivery_System`.`Drone_Details` (`Drone_ID`, `Drone_Status`, `warehouse_ID`, `Drone_Type_ID`) VALUES (42, 'Available', 37, 'A');
INSERT INTO `Delivery_System`.`Drone_Details` (`Drone_ID`, `Drone_Status`, `warehouse_ID`, `Drone_Type_ID`) VALUES (43, 'Available', 49, 'A');
INSERT INTO `Delivery_System`.`Drone_Details` (`Drone_ID`, `Drone_Status`, `warehouse_ID`, `Drone_Type_ID`) VALUES (44, 'Available', 42, 'A');
INSERT INTO `Delivery_System`.`Drone_Details` (`Drone_ID`, `Drone_Status`, `warehouse_ID`, `Drone_Type_ID`) VALUES (45, 'Available', 42, 'A');
INSERT INTO `Delivery_System`.`Drone_Details` (`Drone_ID`, `Drone_Status`, `warehouse_ID`, `Drone_Type_ID`) VALUES (46, 'Available', 43, 'A');
INSERT INTO `Delivery_System`.`Drone_Details` (`Drone_ID`, `Drone_Status`, `warehouse_ID`, `Drone_Type_ID`) VALUES (47, 'Available', 42, 'A');
INSERT INTO `Delivery_System`.`Drone_Details` (`Drone_ID`, `Drone_Status`, `warehouse_ID`, `Drone_Type_ID`) VALUES (48, 'Available', 39, 'A');
INSERT INTO `Delivery_System`.`Drone_Details` (`Drone_ID`, `Drone_Status`, `warehouse_ID`, `Drone_Type_ID`) VALUES (49, 'Available', 40, 'A');
INSERT INTO `Delivery_System`.`Drone_Details` (`Drone_ID`, `Drone_Status`, `warehouse_ID`, `Drone_Type_ID`) VALUES (50, 'Available', 47, 'A');
INSERT INTO `Delivery_System`.`Drone_Details` (`Drone_ID`, `Drone_Status`, `warehouse_ID`, `Drone_Type_ID`) VALUES (51, 'Available', 42, 'A');
INSERT INTO `Delivery_System`.`Drone_Details` (`Drone_ID`, `Drone_Status`, `warehouse_ID`, `Drone_Type_ID`) VALUES (52, 'Available', 43, 'A');
INSERT INTO `Delivery_System`.`Drone_Details` (`Drone_ID`, `Drone_Status`, `warehouse_ID`, `Drone_Type_ID`) VALUES (53, 'Available', 31, 'A');
INSERT INTO `Delivery_System`.`Drone_Details` (`Drone_ID`, `Drone_Status`, `warehouse_ID`, `Drone_Type_ID`) VALUES (54, 'Available', 41, 'A');
INSERT INTO `Delivery_System`.`Drone_Details` (`Drone_ID`, `Drone_Status`, `warehouse_ID`, `Drone_Type_ID`) VALUES (55, 'Available', 37, 'A');
INSERT INTO `Delivery_System`.`Drone_Details` (`Drone_ID`, `Drone_Status`, `warehouse_ID`, `Drone_Type_ID`) VALUES (56, 'Unavailable', 37, 'A');
INSERT INTO `Delivery_System`.`Drone_Details` (`Drone_ID`, `Drone_Status`, `warehouse_ID`, `Drone_Type_ID`) VALUES (57, 'Available', 41, 'A');
INSERT INTO `Delivery_System`.`Drone_Details` (`Drone_ID`, `Drone_Status`, `warehouse_ID`, `Drone_Type_ID`) VALUES (58, 'Available', 31, 'A');
INSERT INTO `Delivery_System`.`Drone_Details` (`Drone_ID`, `Drone_Status`, `warehouse_ID`, `Drone_Type_ID`) VALUES (59, 'Available', 34, 'A');
INSERT INTO `Delivery_System`.`Drone_Details` (`Drone_ID`, `Drone_Status`, `warehouse_ID`, `Drone_Type_ID`) VALUES (60, 'Available', 44, 'A');
INSERT INTO `Delivery_System`.`Drone_Details` (`Drone_ID`, `Drone_Status`, `warehouse_ID`, `Drone_Type_ID`) VALUES (61, 'Available', 36, 'A');
INSERT INTO `Delivery_System`.`Drone_Details` (`Drone_ID`, `Drone_Status`, `warehouse_ID`, `Drone_Type_ID`) VALUES (62, 'Available', 50, 'A');
INSERT INTO `Delivery_System`.`Drone_Details` (`Drone_ID`, `Drone_Status`, `warehouse_ID`, `Drone_Type_ID`) VALUES (63, 'Available', 43, 'A');
INSERT INTO `Delivery_System`.`Drone_Details` (`Drone_ID`, `Drone_Status`, `warehouse_ID`, `Drone_Type_ID`) VALUES (64, 'Available', 39, 'A');
INSERT INTO `Delivery_System`.`Drone_Details` (`Drone_ID`, `Drone_Status`, `warehouse_ID`, `Drone_Type_ID`) VALUES (65, 'Available', 33, 'A');
INSERT INTO `Delivery_System`.`Drone_Details` (`Drone_ID`, `Drone_Status`, `warehouse_ID`, `Drone_Type_ID`) VALUES (66, 'Available', 42, 'A');
INSERT INTO `Delivery_System`.`Drone_Details` (`Drone_ID`, `Drone_Status`, `warehouse_ID`, `Drone_Type_ID`) VALUES (67, 'Available', 47, 'A');
INSERT INTO `Delivery_System`.`Drone_Details` (`Drone_ID`, `Drone_Status`, `warehouse_ID`, `Drone_Type_ID`) VALUES (68, 'Available', 49, 'A');
INSERT INTO `Delivery_System`.`Drone_Details` (`Drone_ID`, `Drone_Status`, `warehouse_ID`, `Drone_Type_ID`) VALUES (69, 'Available', 32, 'A');
INSERT INTO `Delivery_System`.`Drone_Details` (`Drone_ID`, `Drone_Status`, `warehouse_ID`, `Drone_Type_ID`) VALUES (70, 'Available', 41, 'A');
INSERT INTO `Delivery_System`.`Drone_Details` (`Drone_ID`, `Drone_Status`, `warehouse_ID`, `Drone_Type_ID`) VALUES (71, 'Available', 36, 'A');
INSERT INTO `Delivery_System`.`Drone_Details` (`Drone_ID`, `Drone_Status`, `warehouse_ID`, `Drone_Type_ID`) VALUES (72, 'Available', 34, 'A');
INSERT INTO `Delivery_System`.`Drone_Details` (`Drone_ID`, `Drone_Status`, `warehouse_ID`, `Drone_Type_ID`) VALUES (73, 'Available', 33, 'A');
INSERT INTO `Delivery_System`.`Drone_Details` (`Drone_ID`, `Drone_Status`, `warehouse_ID`, `Drone_Type_ID`) VALUES (74, 'Available', 41, 'A');
INSERT INTO `Delivery_System`.`Drone_Details` (`Drone_ID`, `Drone_Status`, `warehouse_ID`, `Drone_Type_ID`) VALUES (75, 'Available', 32, 'A');
INSERT INTO `Delivery_System`.`Drone_Details` (`Drone_ID`, `Drone_Status`, `warehouse_ID`, `Drone_Type_ID`) VALUES (76, 'Available', 49, 'A');
INSERT INTO `Delivery_System`.`Drone_Details` (`Drone_ID`, `Drone_Status`, `warehouse_ID`, `Drone_Type_ID`) VALUES (77, 'Available', 46, 'A');
INSERT INTO `Delivery_System`.`Drone_Details` (`Drone_ID`, `Drone_Status`, `warehouse_ID`, `Drone_Type_ID`) VALUES (78, 'Unavailable', 19, 'A');
INSERT INTO `Delivery_System`.`Drone_Details` (`Drone_ID`, `Drone_Status`, `warehouse_ID`, `Drone_Type_ID`) VALUES (79, 'Available', 41, 'A');
INSERT INTO `Delivery_System`.`Drone_Details` (`Drone_ID`, `Drone_Status`, `warehouse_ID`, `Drone_Type_ID`) VALUES (80, 'Available', 42, 'A');
INSERT INTO `Delivery_System`.`Drone_Details` (`Drone_ID`, `Drone_Status`, `warehouse_ID`, `Drone_Type_ID`) VALUES (81, 'Available', 45, 'A');
INSERT INTO `Delivery_System`.`Drone_Details` (`Drone_ID`, `Drone_Status`, `warehouse_ID`, `Drone_Type_ID`) VALUES (82, 'Available', 46, 'A');
INSERT INTO `Delivery_System`.`Drone_Details` (`Drone_ID`, `Drone_Status`, `warehouse_ID`, `Drone_Type_ID`) VALUES (83, 'Available', 47, 'A');
INSERT INTO `Delivery_System`.`Drone_Details` (`Drone_ID`, `Drone_Status`, `warehouse_ID`, `Drone_Type_ID`) VALUES (84, 'Available', 34, 'A');
INSERT INTO `Delivery_System`.`Drone_Details` (`Drone_ID`, `Drone_Status`, `warehouse_ID`, `Drone_Type_ID`) VALUES (85, 'Available', 39, 'A');
INSERT INTO `Delivery_System`.`Drone_Details` (`Drone_ID`, `Drone_Status`, `warehouse_ID`, `Drone_Type_ID`) VALUES (86, 'Available', 39, 'A');
INSERT INTO `Delivery_System`.`Drone_Details` (`Drone_ID`, `Drone_Status`, `warehouse_ID`, `Drone_Type_ID`) VALUES (87, 'Available', 43, 'A');
INSERT INTO `Delivery_System`.`Drone_Details` (`Drone_ID`, `Drone_Status`, `warehouse_ID`, `Drone_Type_ID`) VALUES (88, 'Available', 31, 'A');
INSERT INTO `Delivery_System`.`Drone_Details` (`Drone_ID`, `Drone_Status`, `warehouse_ID`, `Drone_Type_ID`) VALUES (89, 'Unavailable', 10, 'A');
INSERT INTO `Delivery_System`.`Drone_Details` (`Drone_ID`, `Drone_Status`, `warehouse_ID`, `Drone_Type_ID`) VALUES (90, 'Available', 34, 'A');
INSERT INTO `Delivery_System`.`Drone_Details` (`Drone_ID`, `Drone_Status`, `warehouse_ID`, `Drone_Type_ID`) VALUES (91, 'Available', 37, 'A');
INSERT INTO `Delivery_System`.`Drone_Details` (`Drone_ID`, `Drone_Status`, `warehouse_ID`, `Drone_Type_ID`) VALUES (92, 'Available', 45, 'A');
INSERT INTO `Delivery_System`.`Drone_Details` (`Drone_ID`, `Drone_Status`, `warehouse_ID`, `Drone_Type_ID`) VALUES (93, 'Available', 36, 'A');
INSERT INTO `Delivery_System`.`Drone_Details` (`Drone_ID`, `Drone_Status`, `warehouse_ID`, `Drone_Type_ID`) VALUES (94, 'Available', 42, 'A');
INSERT INTO `Delivery_System`.`Drone_Details` (`Drone_ID`, `Drone_Status`, `warehouse_ID`, `Drone_Type_ID`) VALUES (95, 'Available', 40, 'A');
INSERT INTO `Delivery_System`.`Drone_Details` (`Drone_ID`, `Drone_Status`, `warehouse_ID`, `Drone_Type_ID`) VALUES (96, 'Available', 37, 'A');
INSERT INTO `Delivery_System`.`Drone_Details` (`Drone_ID`, `Drone_Status`, `warehouse_ID`, `Drone_Type_ID`) VALUES (97, 'Available', 47, 'A');
INSERT INTO `Delivery_System`.`Drone_Details` (`Drone_ID`, `Drone_Status`, `warehouse_ID`, `Drone_Type_ID`) VALUES (98, 'Available', 50, 'A');
INSERT INTO `Delivery_System`.`Drone_Details` (`Drone_ID`, `Drone_Status`, `warehouse_ID`, `Drone_Type_ID`) VALUES (99, 'Available', 31, 'A');
INSERT INTO `Delivery_System`.`Drone_Details` (`Drone_ID`, `Drone_Status`, `warehouse_ID`, `Drone_Type_ID`) VALUES (100, 'Available', 33, 'A');
INSERT INTO `Delivery_System`.`Drone_Details` (`Drone_ID`, `Drone_Status`, `warehouse_ID`, `Drone_Type_ID`) VALUES (101, 'Available', 37, 'A');
INSERT INTO `Delivery_System`.`Drone_Details` (`Drone_ID`, `Drone_Status`, `warehouse_ID`, `Drone_Type_ID`) VALUES (102, 'Available', 47, 'A');
INSERT INTO `Delivery_System`.`Drone_Details` (`Drone_ID`, `Drone_Status`, `warehouse_ID`, `Drone_Type_ID`) VALUES (103, 'Available', 32, 'A');
INSERT INTO `Delivery_System`.`Drone_Details` (`Drone_ID`, `Drone_Status`, `warehouse_ID`, `Drone_Type_ID`) VALUES (104, 'Available', 46, 'A');
INSERT INTO `Delivery_System`.`Drone_Details` (`Drone_ID`, `Drone_Status`, `warehouse_ID`, `Drone_Type_ID`) VALUES (105, 'Available', 43, 'A');
INSERT INTO `Delivery_System`.`Drone_Details` (`Drone_ID`, `Drone_Status`, `warehouse_ID`, `Drone_Type_ID`) VALUES (106, 'Available', 41, 'A');
INSERT INTO `Delivery_System`.`Drone_Details` (`Drone_ID`, `Drone_Status`, `warehouse_ID`, `Drone_Type_ID`) VALUES (107, 'Available', 31, 'A');
INSERT INTO `Delivery_System`.`Drone_Details` (`Drone_ID`, `Drone_Status`, `warehouse_ID`, `Drone_Type_ID`) VALUES (108, 'Available', 37, 'A');
INSERT INTO `Delivery_System`.`Drone_Details` (`Drone_ID`, `Drone_Status`, `warehouse_ID`, `Drone_Type_ID`) VALUES (109, 'Available', 43, 'A');
INSERT INTO `Delivery_System`.`Drone_Details` (`Drone_ID`, `Drone_Status`, `warehouse_ID`, `Drone_Type_ID`) VALUES (110, 'Available', 47, 'A');
INSERT INTO `Delivery_System`.`Drone_Details` (`Drone_ID`, `Drone_Status`, `warehouse_ID`, `Drone_Type_ID`) VALUES (111, 'Available', 45, 'A');
INSERT INTO `Delivery_System`.`Drone_Details` (`Drone_ID`, `Drone_Status`, `warehouse_ID`, `Drone_Type_ID`) VALUES (112, 'Unavailable', 22, 'A');
INSERT INTO `Delivery_System`.`Drone_Details` (`Drone_ID`, `Drone_Status`, `warehouse_ID`, `Drone_Type_ID`) VALUES (113, 'Available', 47, 'A');
INSERT INTO `Delivery_System`.`Drone_Details` (`Drone_ID`, `Drone_Status`, `warehouse_ID`, `Drone_Type_ID`) VALUES (114, 'Available', 42, 'A');
INSERT INTO `Delivery_System`.`Drone_Details` (`Drone_ID`, `Drone_Status`, `warehouse_ID`, `Drone_Type_ID`) VALUES (115, 'Available', 41, 'A');
INSERT INTO `Delivery_System`.`Drone_Details` (`Drone_ID`, `Drone_Status`, `warehouse_ID`, `Drone_Type_ID`) VALUES (116, 'Available', 33, 'A');
INSERT INTO `Delivery_System`.`Drone_Details` (`Drone_ID`, `Drone_Status`, `warehouse_ID`, `Drone_Type_ID`) VALUES (117, 'Available', 49, 'A');
INSERT INTO `Delivery_System`.`Drone_Details` (`Drone_ID`, `Drone_Status`, `warehouse_ID`, `Drone_Type_ID`) VALUES (118, 'Available', 41, 'A');
INSERT INTO `Delivery_System`.`Drone_Details` (`Drone_ID`, `Drone_Status`, `warehouse_ID`, `Drone_Type_ID`) VALUES (119, 'Available', 37, 'A');
INSERT INTO `Delivery_System`.`Drone_Details` (`Drone_ID`, `Drone_Status`, `warehouse_ID`, `Drone_Type_ID`) VALUES (120, 'Available', 47, 'A');
INSERT INTO `Delivery_System`.`Drone_Details` (`Drone_ID`, `Drone_Status`, `warehouse_ID`, `Drone_Type_ID`) VALUES (121, 'Available', 50, 'B');
INSERT INTO `Delivery_System`.`Drone_Details` (`Drone_ID`, `Drone_Status`, `warehouse_ID`, `Drone_Type_ID`) VALUES (122, 'Available', 31, 'B');
INSERT INTO `Delivery_System`.`Drone_Details` (`Drone_ID`, `Drone_Status`, `warehouse_ID`, `Drone_Type_ID`) VALUES (123, 'Available', 31, 'B');
INSERT INTO `Delivery_System`.`Drone_Details` (`Drone_ID`, `Drone_Status`, `warehouse_ID`, `Drone_Type_ID`) VALUES (124, 'Available', 42, 'B');
INSERT INTO `Delivery_System`.`Drone_Details` (`Drone_ID`, `Drone_Status`, `warehouse_ID`, `Drone_Type_ID`) VALUES (125, 'Available', 45, 'B');
INSERT INTO `Delivery_System`.`Drone_Details` (`Drone_ID`, `Drone_Status`, `warehouse_ID`, `Drone_Type_ID`) VALUES (126, 'Available', 45, 'B');
INSERT INTO `Delivery_System`.`Drone_Details` (`Drone_ID`, `Drone_Status`, `warehouse_ID`, `Drone_Type_ID`) VALUES (127, 'Available', 40, 'B');
INSERT INTO `Delivery_System`.`Drone_Details` (`Drone_ID`, `Drone_Status`, `warehouse_ID`, `Drone_Type_ID`) VALUES (128, 'Available', 48, 'B');
INSERT INTO `Delivery_System`.`Drone_Details` (`Drone_ID`, `Drone_Status`, `warehouse_ID`, `Drone_Type_ID`) VALUES (129, 'Available', 40, 'B');
INSERT INTO `Delivery_System`.`Drone_Details` (`Drone_ID`, `Drone_Status`, `warehouse_ID`, `Drone_Type_ID`) VALUES (130, 'Available', 32, 'B');
INSERT INTO `Delivery_System`.`Drone_Details` (`Drone_ID`, `Drone_Status`, `warehouse_ID`, `Drone_Type_ID`) VALUES (131, 'Available', 35, 'B');
INSERT INTO `Delivery_System`.`Drone_Details` (`Drone_ID`, `Drone_Status`, `warehouse_ID`, `Drone_Type_ID`) VALUES (132, 'Available', 33, 'B');
INSERT INTO `Delivery_System`.`Drone_Details` (`Drone_ID`, `Drone_Status`, `warehouse_ID`, `Drone_Type_ID`) VALUES (133, 'Available', 46, 'B');
INSERT INTO `Delivery_System`.`Drone_Details` (`Drone_ID`, `Drone_Status`, `warehouse_ID`, `Drone_Type_ID`) VALUES (134, 'Available', 40, 'B');
INSERT INTO `Delivery_System`.`Drone_Details` (`Drone_ID`, `Drone_Status`, `warehouse_ID`, `Drone_Type_ID`) VALUES (135, 'Available', 43, 'B');
INSERT INTO `Delivery_System`.`Drone_Details` (`Drone_ID`, `Drone_Status`, `warehouse_ID`, `Drone_Type_ID`) VALUES (136, 'Available', 37, 'B');
INSERT INTO `Delivery_System`.`Drone_Details` (`Drone_ID`, `Drone_Status`, `warehouse_ID`, `Drone_Type_ID`) VALUES (137, 'Available', 38, 'B');
INSERT INTO `Delivery_System`.`Drone_Details` (`Drone_ID`, `Drone_Status`, `warehouse_ID`, `Drone_Type_ID`) VALUES (138, 'Available', 39, 'B');
INSERT INTO `Delivery_System`.`Drone_Details` (`Drone_ID`, `Drone_Status`, `warehouse_ID`, `Drone_Type_ID`) VALUES (139, 'Available', 50, 'B');
INSERT INTO `Delivery_System`.`Drone_Details` (`Drone_ID`, `Drone_Status`, `warehouse_ID`, `Drone_Type_ID`) VALUES (140, 'Available', 37, 'B');
INSERT INTO `Delivery_System`.`Drone_Details` (`Drone_ID`, `Drone_Status`, `warehouse_ID`, `Drone_Type_ID`) VALUES (141, 'Available', 48, 'B');
INSERT INTO `Delivery_System`.`Drone_Details` (`Drone_ID`, `Drone_Status`, `warehouse_ID`, `Drone_Type_ID`) VALUES (142, 'Available', 31, 'B');
INSERT INTO `Delivery_System`.`Drone_Details` (`Drone_ID`, `Drone_Status`, `warehouse_ID`, `Drone_Type_ID`) VALUES (143, 'Available', 38, 'B');
INSERT INTO `Delivery_System`.`Drone_Details` (`Drone_ID`, `Drone_Status`, `warehouse_ID`, `Drone_Type_ID`) VALUES (144, 'Available', 36, 'B');
INSERT INTO `Delivery_System`.`Drone_Details` (`Drone_ID`, `Drone_Status`, `warehouse_ID`, `Drone_Type_ID`) VALUES (145, 'Available', 43, 'B');
INSERT INTO `Delivery_System`.`Drone_Details` (`Drone_ID`, `Drone_Status`, `warehouse_ID`, `Drone_Type_ID`) VALUES (146, 'Unavailable', 49, 'B');
INSERT INTO `Delivery_System`.`Drone_Details` (`Drone_ID`, `Drone_Status`, `warehouse_ID`, `Drone_Type_ID`) VALUES (147, 'Available', 45, 'B');
INSERT INTO `Delivery_System`.`Drone_Details` (`Drone_ID`, `Drone_Status`, `warehouse_ID`, `Drone_Type_ID`) VALUES (148, 'Available', 40, 'B');
INSERT INTO `Delivery_System`.`Drone_Details` (`Drone_ID`, `Drone_Status`, `warehouse_ID`, `Drone_Type_ID`) VALUES (149, 'Available', 37, 'B');
INSERT INTO `Delivery_System`.`Drone_Details` (`Drone_ID`, `Drone_Status`, `warehouse_ID`, `Drone_Type_ID`) VALUES (150, 'Available', 35, 'B');
INSERT INTO `Delivery_System`.`Drone_Details` (`Drone_ID`, `Drone_Status`, `warehouse_ID`, `Drone_Type_ID`) VALUES (151, 'Available', 35, 'B');
INSERT INTO `Delivery_System`.`Drone_Details` (`Drone_ID`, `Drone_Status`, `warehouse_ID`, `Drone_Type_ID`) VALUES (152, 'Available', 44, 'B');
INSERT INTO `Delivery_System`.`Drone_Details` (`Drone_ID`, `Drone_Status`, `warehouse_ID`, `Drone_Type_ID`) VALUES (153, 'Available', 33, 'B');
INSERT INTO `Delivery_System`.`Drone_Details` (`Drone_ID`, `Drone_Status`, `warehouse_ID`, `Drone_Type_ID`) VALUES (154, 'Available', 34, 'B');
INSERT INTO `Delivery_System`.`Drone_Details` (`Drone_ID`, `Drone_Status`, `warehouse_ID`, `Drone_Type_ID`) VALUES (155, 'Available', 48, 'B');
INSERT INTO `Delivery_System`.`Drone_Details` (`Drone_ID`, `Drone_Status`, `warehouse_ID`, `Drone_Type_ID`) VALUES (156, 'Available', 48, 'B');
INSERT INTO `Delivery_System`.`Drone_Details` (`Drone_ID`, `Drone_Status`, `warehouse_ID`, `Drone_Type_ID`) VALUES (157, 'Available', 47, 'B');
INSERT INTO `Delivery_System`.`Drone_Details` (`Drone_ID`, `Drone_Status`, `warehouse_ID`, `Drone_Type_ID`) VALUES (158, 'Available', 42, 'B');
INSERT INTO `Delivery_System`.`Drone_Details` (`Drone_ID`, `Drone_Status`, `warehouse_ID`, `Drone_Type_ID`) VALUES (159, 'Available', 36, 'B');
INSERT INTO `Delivery_System`.`Drone_Details` (`Drone_ID`, `Drone_Status`, `warehouse_ID`, `Drone_Type_ID`) VALUES (160, 'Available', 48, 'B');
INSERT INTO `Delivery_System`.`Drone_Details` (`Drone_ID`, `Drone_Status`, `warehouse_ID`, `Drone_Type_ID`) VALUES (161, 'Available', 31, 'B');
INSERT INTO `Delivery_System`.`Drone_Details` (`Drone_ID`, `Drone_Status`, `warehouse_ID`, `Drone_Type_ID`) VALUES (162, 'Available', 39, 'B');
INSERT INTO `Delivery_System`.`Drone_Details` (`Drone_ID`, `Drone_Status`, `warehouse_ID`, `Drone_Type_ID`) VALUES (163, 'Unavailable', 48, 'B');
INSERT INTO `Delivery_System`.`Drone_Details` (`Drone_ID`, `Drone_Status`, `warehouse_ID`, `Drone_Type_ID`) VALUES (164, 'Available', 47, 'B');
INSERT INTO `Delivery_System`.`Drone_Details` (`Drone_ID`, `Drone_Status`, `warehouse_ID`, `Drone_Type_ID`) VALUES (165, 'Available', 48, 'B');
INSERT INTO `Delivery_System`.`Drone_Details` (`Drone_ID`, `Drone_Status`, `warehouse_ID`, `Drone_Type_ID`) VALUES (166, 'Available', 42, 'B');
INSERT INTO `Delivery_System`.`Drone_Details` (`Drone_ID`, `Drone_Status`, `warehouse_ID`, `Drone_Type_ID`) VALUES (167, 'Available', 48, 'B');
INSERT INTO `Delivery_System`.`Drone_Details` (`Drone_ID`, `Drone_Status`, `warehouse_ID`, `Drone_Type_ID`) VALUES (168, 'Available', 50, 'B');
INSERT INTO `Delivery_System`.`Drone_Details` (`Drone_ID`, `Drone_Status`, `warehouse_ID`, `Drone_Type_ID`) VALUES (169, 'Available', 34, 'B');
INSERT INTO `Delivery_System`.`Drone_Details` (`Drone_ID`, `Drone_Status`, `warehouse_ID`, `Drone_Type_ID`) VALUES (170, 'Available', 50, 'B');
INSERT INTO `Delivery_System`.`Drone_Details` (`Drone_ID`, `Drone_Status`, `warehouse_ID`, `Drone_Type_ID`) VALUES (171, 'Available', 38, 'B');
INSERT INTO `Delivery_System`.`Drone_Details` (`Drone_ID`, `Drone_Status`, `warehouse_ID`, `Drone_Type_ID`) VALUES (172, 'Available', 39, 'B');
INSERT INTO `Delivery_System`.`Drone_Details` (`Drone_ID`, `Drone_Status`, `warehouse_ID`, `Drone_Type_ID`) VALUES (173, 'Available', 50, 'B');
INSERT INTO `Delivery_System`.`Drone_Details` (`Drone_ID`, `Drone_Status`, `warehouse_ID`, `Drone_Type_ID`) VALUES (174, 'Available', 46, 'B');
INSERT INTO `Delivery_System`.`Drone_Details` (`Drone_ID`, `Drone_Status`, `warehouse_ID`, `Drone_Type_ID`) VALUES (175, 'Available', 50, 'B');
INSERT INTO `Delivery_System`.`Drone_Details` (`Drone_ID`, `Drone_Status`, `warehouse_ID`, `Drone_Type_ID`) VALUES (176, 'Available', 31, 'B');
INSERT INTO `Delivery_System`.`Drone_Details` (`Drone_ID`, `Drone_Status`, `warehouse_ID`, `Drone_Type_ID`) VALUES (177, 'Available', 34, 'B');
INSERT INTO `Delivery_System`.`Drone_Details` (`Drone_ID`, `Drone_Status`, `warehouse_ID`, `Drone_Type_ID`) VALUES (178, 'Available', 34, 'B');
INSERT INTO `Delivery_System`.`Drone_Details` (`Drone_ID`, `Drone_Status`, `warehouse_ID`, `Drone_Type_ID`) VALUES (179, 'Available', 43, 'B');
INSERT INTO `Delivery_System`.`Drone_Details` (`Drone_ID`, `Drone_Status`, `warehouse_ID`, `Drone_Type_ID`) VALUES (180, 'Available', 50, 'B');
INSERT INTO `Delivery_System`.`Drone_Details` (`Drone_ID`, `Drone_Status`, `warehouse_ID`, `Drone_Type_ID`) VALUES (181, 'Available', 35, 'B');
INSERT INTO `Delivery_System`.`Drone_Details` (`Drone_ID`, `Drone_Status`, `warehouse_ID`, `Drone_Type_ID`) VALUES (182, 'Available', 37, 'B');
INSERT INTO `Delivery_System`.`Drone_Details` (`Drone_ID`, `Drone_Status`, `warehouse_ID`, `Drone_Type_ID`) VALUES (183, 'Available', 42, 'B');
INSERT INTO `Delivery_System`.`Drone_Details` (`Drone_ID`, `Drone_Status`, `warehouse_ID`, `Drone_Type_ID`) VALUES (184, 'Available', 37, 'B');
INSERT INTO `Delivery_System`.`Drone_Details` (`Drone_ID`, `Drone_Status`, `warehouse_ID`, `Drone_Type_ID`) VALUES (185, 'Available', 41, 'B');
INSERT INTO `Delivery_System`.`Drone_Details` (`Drone_ID`, `Drone_Status`, `warehouse_ID`, `Drone_Type_ID`) VALUES (186, 'Available', 39, 'B');
INSERT INTO `Delivery_System`.`Drone_Details` (`Drone_ID`, `Drone_Status`, `warehouse_ID`, `Drone_Type_ID`) VALUES (187, 'Available', 45, 'B');
INSERT INTO `Delivery_System`.`Drone_Details` (`Drone_ID`, `Drone_Status`, `warehouse_ID`, `Drone_Type_ID`) VALUES (188, 'Available', 46, 'B');
INSERT INTO `Delivery_System`.`Drone_Details` (`Drone_ID`, `Drone_Status`, `warehouse_ID`, `Drone_Type_ID`) VALUES (189, 'Available', 34, 'B');
INSERT INTO `Delivery_System`.`Drone_Details` (`Drone_ID`, `Drone_Status`, `warehouse_ID`, `Drone_Type_ID`) VALUES (190, 'Available', 32, 'B');
INSERT INTO `Delivery_System`.`Drone_Details` (`Drone_ID`, `Drone_Status`, `warehouse_ID`, `Drone_Type_ID`) VALUES (191, 'Available', 41, 'B');
INSERT INTO `Delivery_System`.`Drone_Details` (`Drone_ID`, `Drone_Status`, `warehouse_ID`, `Drone_Type_ID`) VALUES (192, 'Available', 36, 'B');
INSERT INTO `Delivery_System`.`Drone_Details` (`Drone_ID`, `Drone_Status`, `warehouse_ID`, `Drone_Type_ID`) VALUES (193, 'Available', 49, 'B');
INSERT INTO `Delivery_System`.`Drone_Details` (`Drone_ID`, `Drone_Status`, `warehouse_ID`, `Drone_Type_ID`) VALUES (194, 'Available', 35, 'B');
INSERT INTO `Delivery_System`.`Drone_Details` (`Drone_ID`, `Drone_Status`, `warehouse_ID`, `Drone_Type_ID`) VALUES (195, 'Available', 38, 'B');
INSERT INTO `Delivery_System`.`Drone_Details` (`Drone_ID`, `Drone_Status`, `warehouse_ID`, `Drone_Type_ID`) VALUES (196, 'Available', 45, 'B');
INSERT INTO `Delivery_System`.`Drone_Details` (`Drone_ID`, `Drone_Status`, `warehouse_ID`, `Drone_Type_ID`) VALUES (197, 'Available', 32, 'B');
INSERT INTO `Delivery_System`.`Drone_Details` (`Drone_ID`, `Drone_Status`, `warehouse_ID`, `Drone_Type_ID`) VALUES (198, 'Available', 36, 'B');
INSERT INTO `Delivery_System`.`Drone_Details` (`Drone_ID`, `Drone_Status`, `warehouse_ID`, `Drone_Type_ID`) VALUES (199, 'Available', 35, 'B');
INSERT INTO `Delivery_System`.`Drone_Details` (`Drone_ID`, `Drone_Status`, `warehouse_ID`, `Drone_Type_ID`) VALUES (200, 'Available', 48, 'B');
INSERT INTO `Delivery_System`.`Drone_Details` (`Drone_ID`, `Drone_Status`, `warehouse_ID`, `Drone_Type_ID`) VALUES (201, 'Available', 36, 'B');
INSERT INTO `Delivery_System`.`Drone_Details` (`Drone_ID`, `Drone_Status`, `warehouse_ID`, `Drone_Type_ID`) VALUES (202, 'Available', 39, 'B');
INSERT INTO `Delivery_System`.`Drone_Details` (`Drone_ID`, `Drone_Status`, `warehouse_ID`, `Drone_Type_ID`) VALUES (203, 'Available', 37, 'B');
INSERT INTO `Delivery_System`.`Drone_Details` (`Drone_ID`, `Drone_Status`, `warehouse_ID`, `Drone_Type_ID`) VALUES (204, 'Available', 42, 'B');
INSERT INTO `Delivery_System`.`Drone_Details` (`Drone_ID`, `Drone_Status`, `warehouse_ID`, `Drone_Type_ID`) VALUES (205, 'Available', 35, 'B');
INSERT INTO `Delivery_System`.`Drone_Details` (`Drone_ID`, `Drone_Status`, `warehouse_ID`, `Drone_Type_ID`) VALUES (206, 'Available', 49, 'B');
INSERT INTO `Delivery_System`.`Drone_Details` (`Drone_ID`, `Drone_Status`, `warehouse_ID`, `Drone_Type_ID`) VALUES (207, 'Available', 31, 'B');
INSERT INTO `Delivery_System`.`Drone_Details` (`Drone_ID`, `Drone_Status`, `warehouse_ID`, `Drone_Type_ID`) VALUES (208, 'Available', 47, 'B');
INSERT INTO `Delivery_System`.`Drone_Details` (`Drone_ID`, `Drone_Status`, `warehouse_ID`, `Drone_Type_ID`) VALUES (209, 'Available', 46, 'B');
INSERT INTO `Delivery_System`.`Drone_Details` (`Drone_ID`, `Drone_Status`, `warehouse_ID`, `Drone_Type_ID`) VALUES (210, 'Available', 42, 'B');
INSERT INTO `Delivery_System`.`Drone_Details` (`Drone_ID`, `Drone_Status`, `warehouse_ID`, `Drone_Type_ID`) VALUES (211, 'Available', 44, 'B');
INSERT INTO `Delivery_System`.`Drone_Details` (`Drone_ID`, `Drone_Status`, `warehouse_ID`, `Drone_Type_ID`) VALUES (212, 'Available', 44, 'B');
INSERT INTO `Delivery_System`.`Drone_Details` (`Drone_ID`, `Drone_Status`, `warehouse_ID`, `Drone_Type_ID`) VALUES (213, 'Available', 45, 'B');
INSERT INTO `Delivery_System`.`Drone_Details` (`Drone_ID`, `Drone_Status`, `warehouse_ID`, `Drone_Type_ID`) VALUES (214, 'Available', 37, 'B');
INSERT INTO `Delivery_System`.`Drone_Details` (`Drone_ID`, `Drone_Status`, `warehouse_ID`, `Drone_Type_ID`) VALUES (215, 'Available', 45, 'B');
INSERT INTO `Delivery_System`.`Drone_Details` (`Drone_ID`, `Drone_Status`, `warehouse_ID`, `Drone_Type_ID`) VALUES (216, 'Available', 38, 'B');
INSERT INTO `Delivery_System`.`Drone_Details` (`Drone_ID`, `Drone_Status`, `warehouse_ID`, `Drone_Type_ID`) VALUES (217, 'Available', 32, 'B');
INSERT INTO `Delivery_System`.`Drone_Details` (`Drone_ID`, `Drone_Status`, `warehouse_ID`, `Drone_Type_ID`) VALUES (218, 'Available', 41, 'B');
INSERT INTO `Delivery_System`.`Drone_Details` (`Drone_ID`, `Drone_Status`, `warehouse_ID`, `Drone_Type_ID`) VALUES (219, 'Available', 38, 'B');
INSERT INTO `Delivery_System`.`Drone_Details` (`Drone_ID`, `Drone_Status`, `warehouse_ID`, `Drone_Type_ID`) VALUES (220, 'Available', 41, 'B');
INSERT INTO `Delivery_System`.`Drone_Details` (`Drone_ID`, `Drone_Status`, `warehouse_ID`, `Drone_Type_ID`) VALUES (221, 'Available', 42, 'C');
INSERT INTO `Delivery_System`.`Drone_Details` (`Drone_ID`, `Drone_Status`, `warehouse_ID`, `Drone_Type_ID`) VALUES (222, 'Available', 48, 'C');
INSERT INTO `Delivery_System`.`Drone_Details` (`Drone_ID`, `Drone_Status`, `warehouse_ID`, `Drone_Type_ID`) VALUES (223, 'Available', 36, 'C');
INSERT INTO `Delivery_System`.`Drone_Details` (`Drone_ID`, `Drone_Status`, `warehouse_ID`, `Drone_Type_ID`) VALUES (224, 'Available', 47, 'C');
INSERT INTO `Delivery_System`.`Drone_Details` (`Drone_ID`, `Drone_Status`, `warehouse_ID`, `Drone_Type_ID`) VALUES (225, 'Available', 36, 'C');
INSERT INTO `Delivery_System`.`Drone_Details` (`Drone_ID`, `Drone_Status`, `warehouse_ID`, `Drone_Type_ID`) VALUES (226, 'Available', 32, 'C');
INSERT INTO `Delivery_System`.`Drone_Details` (`Drone_ID`, `Drone_Status`, `warehouse_ID`, `Drone_Type_ID`) VALUES (227, 'Available', 46, 'C');
INSERT INTO `Delivery_System`.`Drone_Details` (`Drone_ID`, `Drone_Status`, `warehouse_ID`, `Drone_Type_ID`) VALUES (228, 'Available', 35, 'C');
INSERT INTO `Delivery_System`.`Drone_Details` (`Drone_ID`, `Drone_Status`, `warehouse_ID`, `Drone_Type_ID`) VALUES (229, 'Available', 32, 'C');
INSERT INTO `Delivery_System`.`Drone_Details` (`Drone_ID`, `Drone_Status`, `warehouse_ID`, `Drone_Type_ID`) VALUES (230, 'Available', 38, 'C');
INSERT INTO `Delivery_System`.`Drone_Details` (`Drone_ID`, `Drone_Status`, `warehouse_ID`, `Drone_Type_ID`) VALUES (231, 'Available', 34, 'C');
INSERT INTO `Delivery_System`.`Drone_Details` (`Drone_ID`, `Drone_Status`, `warehouse_ID`, `Drone_Type_ID`) VALUES (232, 'Available', 35, 'C');
INSERT INTO `Delivery_System`.`Drone_Details` (`Drone_ID`, `Drone_Status`, `warehouse_ID`, `Drone_Type_ID`) VALUES (233, 'Available', 35, 'C');
INSERT INTO `Delivery_System`.`Drone_Details` (`Drone_ID`, `Drone_Status`, `warehouse_ID`, `Drone_Type_ID`) VALUES (234, 'Available', 33, 'C');
INSERT INTO `Delivery_System`.`Drone_Details` (`Drone_ID`, `Drone_Status`, `warehouse_ID`, `Drone_Type_ID`) VALUES (235, 'Available', 49, 'C');
INSERT INTO `Delivery_System`.`Drone_Details` (`Drone_ID`, `Drone_Status`, `warehouse_ID`, `Drone_Type_ID`) VALUES (236, 'Unavailable', 12, 'C');
INSERT INTO `Delivery_System`.`Drone_Details` (`Drone_ID`, `Drone_Status`, `warehouse_ID`, `Drone_Type_ID`) VALUES (237, 'Available', 44, 'C');
INSERT INTO `Delivery_System`.`Drone_Details` (`Drone_ID`, `Drone_Status`, `warehouse_ID`, `Drone_Type_ID`) VALUES (238, 'Available', 40, 'C');
INSERT INTO `Delivery_System`.`Drone_Details` (`Drone_ID`, `Drone_Status`, `warehouse_ID`, `Drone_Type_ID`) VALUES (239, 'Available', 31, 'C');
INSERT INTO `Delivery_System`.`Drone_Details` (`Drone_ID`, `Drone_Status`, `warehouse_ID`, `Drone_Type_ID`) VALUES (240, 'Available', 45, 'C');
INSERT INTO `Delivery_System`.`Drone_Details` (`Drone_ID`, `Drone_Status`, `warehouse_ID`, `Drone_Type_ID`) VALUES (241, 'Available', 45, 'C');
INSERT INTO `Delivery_System`.`Drone_Details` (`Drone_ID`, `Drone_Status`, `warehouse_ID`, `Drone_Type_ID`) VALUES (242, 'Available', 47, 'C');
INSERT INTO `Delivery_System`.`Drone_Details` (`Drone_ID`, `Drone_Status`, `warehouse_ID`, `Drone_Type_ID`) VALUES (243, 'Available', 39, 'C');
INSERT INTO `Delivery_System`.`Drone_Details` (`Drone_ID`, `Drone_Status`, `warehouse_ID`, `Drone_Type_ID`) VALUES (244, 'Available', 44, 'C');
INSERT INTO `Delivery_System`.`Drone_Details` (`Drone_ID`, `Drone_Status`, `warehouse_ID`, `Drone_Type_ID`) VALUES (245, 'Available', 35, 'C');
INSERT INTO `Delivery_System`.`Drone_Details` (`Drone_ID`, `Drone_Status`, `warehouse_ID`, `Drone_Type_ID`) VALUES (246, 'Available', 44, 'C');
INSERT INTO `Delivery_System`.`Drone_Details` (`Drone_ID`, `Drone_Status`, `warehouse_ID`, `Drone_Type_ID`) VALUES (247, 'Available', 49, 'C');
INSERT INTO `Delivery_System`.`Drone_Details` (`Drone_ID`, `Drone_Status`, `warehouse_ID`, `Drone_Type_ID`) VALUES (248, 'Available', 46, 'C');
INSERT INTO `Delivery_System`.`Drone_Details` (`Drone_ID`, `Drone_Status`, `warehouse_ID`, `Drone_Type_ID`) VALUES (249, 'Available', 34, 'C');
INSERT INTO `Delivery_System`.`Drone_Details` (`Drone_ID`, `Drone_Status`, `warehouse_ID`, `Drone_Type_ID`) VALUES (250, 'Available', 42, 'C');
INSERT INTO `Delivery_System`.`Drone_Details` (`Drone_ID`, `Drone_Status`, `warehouse_ID`, `Drone_Type_ID`) VALUES (251, 'Available', 33, 'C');
INSERT INTO `Delivery_System`.`Drone_Details` (`Drone_ID`, `Drone_Status`, `warehouse_ID`, `Drone_Type_ID`) VALUES (252, 'Available', 45, 'C');
INSERT INTO `Delivery_System`.`Drone_Details` (`Drone_ID`, `Drone_Status`, `warehouse_ID`, `Drone_Type_ID`) VALUES (253, 'Available', 37, 'C');
INSERT INTO `Delivery_System`.`Drone_Details` (`Drone_ID`, `Drone_Status`, `warehouse_ID`, `Drone_Type_ID`) VALUES (254, 'Available', 41, 'C');
INSERT INTO `Delivery_System`.`Drone_Details` (`Drone_ID`, `Drone_Status`, `warehouse_ID`, `Drone_Type_ID`) VALUES (255, 'Available', 34, 'C');
INSERT INTO `Delivery_System`.`Drone_Details` (`Drone_ID`, `Drone_Status`, `warehouse_ID`, `Drone_Type_ID`) VALUES (256, 'Available', 44, 'C');
INSERT INTO `Delivery_System`.`Drone_Details` (`Drone_ID`, `Drone_Status`, `warehouse_ID`, `Drone_Type_ID`) VALUES (257, 'Available', 44, 'C');
INSERT INTO `Delivery_System`.`Drone_Details` (`Drone_ID`, `Drone_Status`, `warehouse_ID`, `Drone_Type_ID`) VALUES (258, 'Available', 33, 'C');
INSERT INTO `Delivery_System`.`Drone_Details` (`Drone_ID`, `Drone_Status`, `warehouse_ID`, `Drone_Type_ID`) VALUES (259, 'Available', 50, 'C');
INSERT INTO `Delivery_System`.`Drone_Details` (`Drone_ID`, `Drone_Status`, `warehouse_ID`, `Drone_Type_ID`) VALUES (260, 'Available', 46, 'C');
INSERT INTO `Delivery_System`.`Drone_Details` (`Drone_ID`, `Drone_Status`, `warehouse_ID`, `Drone_Type_ID`) VALUES (261, 'Available', 50, 'C');
INSERT INTO `Delivery_System`.`Drone_Details` (`Drone_ID`, `Drone_Status`, `warehouse_ID`, `Drone_Type_ID`) VALUES (262, 'Available', 37, 'C');
INSERT INTO `Delivery_System`.`Drone_Details` (`Drone_ID`, `Drone_Status`, `warehouse_ID`, `Drone_Type_ID`) VALUES (263, 'Available', 49, 'C');
INSERT INTO `Delivery_System`.`Drone_Details` (`Drone_ID`, `Drone_Status`, `warehouse_ID`, `Drone_Type_ID`) VALUES (264, 'Available', 42, 'C');
INSERT INTO `Delivery_System`.`Drone_Details` (`Drone_ID`, `Drone_Status`, `warehouse_ID`, `Drone_Type_ID`) VALUES (265, 'Available', 33, 'C');
INSERT INTO `Delivery_System`.`Drone_Details` (`Drone_ID`, `Drone_Status`, `warehouse_ID`, `Drone_Type_ID`) VALUES (266, 'Available', 49, 'C');
INSERT INTO `Delivery_System`.`Drone_Details` (`Drone_ID`, `Drone_Status`, `warehouse_ID`, `Drone_Type_ID`) VALUES (267, 'Available', 48, 'C');
INSERT INTO `Delivery_System`.`Drone_Details` (`Drone_ID`, `Drone_Status`, `warehouse_ID`, `Drone_Type_ID`) VALUES (268, 'Available', 37, 'C');
INSERT INTO `Delivery_System`.`Drone_Details` (`Drone_ID`, `Drone_Status`, `warehouse_ID`, `Drone_Type_ID`) VALUES (269, 'Available', 35, 'C');
INSERT INTO `Delivery_System`.`Drone_Details` (`Drone_ID`, `Drone_Status`, `warehouse_ID`, `Drone_Type_ID`) VALUES (270, 'Available', 31, 'C');
INSERT INTO `Delivery_System`.`Drone_Details` (`Drone_ID`, `Drone_Status`, `warehouse_ID`, `Drone_Type_ID`) VALUES (271, 'Unavailable', 42, 'C');
INSERT INTO `Delivery_System`.`Drone_Details` (`Drone_ID`, `Drone_Status`, `warehouse_ID`, `Drone_Type_ID`) VALUES (272, 'Available', 41, 'C');
INSERT INTO `Delivery_System`.`Drone_Details` (`Drone_ID`, `Drone_Status`, `warehouse_ID`, `Drone_Type_ID`) VALUES (273, 'Available', 45, 'C');
INSERT INTO `Delivery_System`.`Drone_Details` (`Drone_ID`, `Drone_Status`, `warehouse_ID`, `Drone_Type_ID`) VALUES (274, 'Available', 37, 'C');
INSERT INTO `Delivery_System`.`Drone_Details` (`Drone_ID`, `Drone_Status`, `warehouse_ID`, `Drone_Type_ID`) VALUES (275, 'Available', 32, 'C');
INSERT INTO `Delivery_System`.`Drone_Details` (`Drone_ID`, `Drone_Status`, `warehouse_ID`, `Drone_Type_ID`) VALUES (276, 'Available', 37, 'C');
INSERT INTO `Delivery_System`.`Drone_Details` (`Drone_ID`, `Drone_Status`, `warehouse_ID`, `Drone_Type_ID`) VALUES (277, 'Available', 47, 'C');
INSERT INTO `Delivery_System`.`Drone_Details` (`Drone_ID`, `Drone_Status`, `warehouse_ID`, `Drone_Type_ID`) VALUES (278, 'Available', 43, 'C');
INSERT INTO `Delivery_System`.`Drone_Details` (`Drone_ID`, `Drone_Status`, `warehouse_ID`, `Drone_Type_ID`) VALUES (279, 'Available', 46, 'C');
INSERT INTO `Delivery_System`.`Drone_Details` (`Drone_ID`, `Drone_Status`, `warehouse_ID`, `Drone_Type_ID`) VALUES (280, 'Available', 32, 'C');
INSERT INTO `Delivery_System`.`Drone_Details` (`Drone_ID`, `Drone_Status`, `warehouse_ID`, `Drone_Type_ID`) VALUES (281, 'Available', 40, 'D');
INSERT INTO `Delivery_System`.`Drone_Details` (`Drone_ID`, `Drone_Status`, `warehouse_ID`, `Drone_Type_ID`) VALUES (282, 'Available', 45, 'D');
INSERT INTO `Delivery_System`.`Drone_Details` (`Drone_ID`, `Drone_Status`, `warehouse_ID`, `Drone_Type_ID`) VALUES (283, 'Available', 41, 'D');
INSERT INTO `Delivery_System`.`Drone_Details` (`Drone_ID`, `Drone_Status`, `warehouse_ID`, `Drone_Type_ID`) VALUES (284, 'Available', 40, 'D');
INSERT INTO `Delivery_System`.`Drone_Details` (`Drone_ID`, `Drone_Status`, `warehouse_ID`, `Drone_Type_ID`) VALUES (285, 'Available', 31, 'D');
INSERT INTO `Delivery_System`.`Drone_Details` (`Drone_ID`, `Drone_Status`, `warehouse_ID`, `Drone_Type_ID`) VALUES (286, 'Available', 49, 'D');
INSERT INTO `Delivery_System`.`Drone_Details` (`Drone_ID`, `Drone_Status`, `warehouse_ID`, `Drone_Type_ID`) VALUES (287, 'Available', 50, 'D');
INSERT INTO `Delivery_System`.`Drone_Details` (`Drone_ID`, `Drone_Status`, `warehouse_ID`, `Drone_Type_ID`) VALUES (288, 'Available', 49, 'D');
INSERT INTO `Delivery_System`.`Drone_Details` (`Drone_ID`, `Drone_Status`, `warehouse_ID`, `Drone_Type_ID`) VALUES (289, 'Available', 40, 'D');
INSERT INTO `Delivery_System`.`Drone_Details` (`Drone_ID`, `Drone_Status`, `warehouse_ID`, `Drone_Type_ID`) VALUES (290, 'Available', 39, 'D');
INSERT INTO `Delivery_System`.`Drone_Details` (`Drone_ID`, `Drone_Status`, `warehouse_ID`, `Drone_Type_ID`) VALUES (291, 'Available', 45, 'D');
INSERT INTO `Delivery_System`.`Drone_Details` (`Drone_ID`, `Drone_Status`, `warehouse_ID`, `Drone_Type_ID`) VALUES (292, 'Available', 42, 'D');
INSERT INTO `Delivery_System`.`Drone_Details` (`Drone_ID`, `Drone_Status`, `warehouse_ID`, `Drone_Type_ID`) VALUES (293, 'Available', 34, 'D');
INSERT INTO `Delivery_System`.`Drone_Details` (`Drone_ID`, `Drone_Status`, `warehouse_ID`, `Drone_Type_ID`) VALUES (294, 'Available', 44, 'D');
INSERT INTO `Delivery_System`.`Drone_Details` (`Drone_ID`, `Drone_Status`, `warehouse_ID`, `Drone_Type_ID`) VALUES (295, 'Available', 31, 'D');
INSERT INTO `Delivery_System`.`Drone_Details` (`Drone_ID`, `Drone_Status`, `warehouse_ID`, `Drone_Type_ID`) VALUES (296, 'Available', 34, 'D');
INSERT INTO `Delivery_System`.`Drone_Details` (`Drone_ID`, `Drone_Status`, `warehouse_ID`, `Drone_Type_ID`) VALUES (297, 'Available', 34, 'D');
INSERT INTO `Delivery_System`.`Drone_Details` (`Drone_ID`, `Drone_Status`, `warehouse_ID`, `Drone_Type_ID`) VALUES (298, 'Available', 44, 'D');
INSERT INTO `Delivery_System`.`Drone_Details` (`Drone_ID`, `Drone_Status`, `warehouse_ID`, `Drone_Type_ID`) VALUES (299, 'Available', 47, 'D');
INSERT INTO `Delivery_System`.`Drone_Details` (`Drone_ID`, `Drone_Status`, `warehouse_ID`, `Drone_Type_ID`) VALUES (300, 'Available', 35, 'D');
INSERT INTO `Delivery_System`.`Drone_Details` (`Drone_ID`, `Drone_Status`, `warehouse_ID`, `Drone_Type_ID`) VALUES (301, 'Available', 44, 'D');
INSERT INTO `Delivery_System`.`Drone_Details` (`Drone_ID`, `Drone_Status`, `warehouse_ID`, `Drone_Type_ID`) VALUES (302, 'Available', 48, 'D');
INSERT INTO `Delivery_System`.`Drone_Details` (`Drone_ID`, `Drone_Status`, `warehouse_ID`, `Drone_Type_ID`) VALUES (303, 'Available', 48, 'D');
INSERT INTO `Delivery_System`.`Drone_Details` (`Drone_ID`, `Drone_Status`, `warehouse_ID`, `Drone_Type_ID`) VALUES (304, 'Available', 45, 'D');
INSERT INTO `Delivery_System`.`Drone_Details` (`Drone_ID`, `Drone_Status`, `warehouse_ID`, `Drone_Type_ID`) VALUES (305, 'Available', 31, 'D');
INSERT INTO `Delivery_System`.`Drone_Details` (`Drone_ID`, `Drone_Status`, `warehouse_ID`, `Drone_Type_ID`) VALUES (306, 'Available', 43, 'D');
INSERT INTO `Delivery_System`.`Drone_Details` (`Drone_ID`, `Drone_Status`, `warehouse_ID`, `Drone_Type_ID`) VALUES (307, 'Available', 36, 'D');
INSERT INTO `Delivery_System`.`Drone_Details` (`Drone_ID`, `Drone_Status`, `warehouse_ID`, `Drone_Type_ID`) VALUES (308, 'Available', 50, 'D');
INSERT INTO `Delivery_System`.`Drone_Details` (`Drone_ID`, `Drone_Status`, `warehouse_ID`, `Drone_Type_ID`) VALUES (309, 'Available', 46, 'D');
INSERT INTO `Delivery_System`.`Drone_Details` (`Drone_ID`, `Drone_Status`, `warehouse_ID`, `Drone_Type_ID`) VALUES (310, 'Available', 35, 'D');
INSERT INTO `Delivery_System`.`Drone_Details` (`Drone_ID`, `Drone_Status`, `warehouse_ID`, `Drone_Type_ID`) VALUES (311, 'Unavailable', 23, 'D');
INSERT INTO `Delivery_System`.`Drone_Details` (`Drone_ID`, `Drone_Status`, `warehouse_ID`, `Drone_Type_ID`) VALUES (312, 'Available', 37, 'D');
INSERT INTO `Delivery_System`.`Drone_Details` (`Drone_ID`, `Drone_Status`, `warehouse_ID`, `Drone_Type_ID`) VALUES (313, 'Available', 50, 'D');
INSERT INTO `Delivery_System`.`Drone_Details` (`Drone_ID`, `Drone_Status`, `warehouse_ID`, `Drone_Type_ID`) VALUES (314, 'Available', 37, 'D');
INSERT INTO `Delivery_System`.`Drone_Details` (`Drone_ID`, `Drone_Status`, `warehouse_ID`, `Drone_Type_ID`) VALUES (315, 'Available', 31, 'D');
INSERT INTO `Delivery_System`.`Drone_Details` (`Drone_ID`, `Drone_Status`, `warehouse_ID`, `Drone_Type_ID`) VALUES (316, 'Available', 38, 'D');
INSERT INTO `Delivery_System`.`Drone_Details` (`Drone_ID`, `Drone_Status`, `warehouse_ID`, `Drone_Type_ID`) VALUES (317, 'Available', 35, 'D');
INSERT INTO `Delivery_System`.`Drone_Details` (`Drone_ID`, `Drone_Status`, `warehouse_ID`, `Drone_Type_ID`) VALUES (318, 'Available', 31, 'D');
INSERT INTO `Delivery_System`.`Drone_Details` (`Drone_ID`, `Drone_Status`, `warehouse_ID`, `Drone_Type_ID`) VALUES (319, 'Available', 36, 'D');
INSERT INTO `Delivery_System`.`Drone_Details` (`Drone_ID`, `Drone_Status`, `warehouse_ID`, `Drone_Type_ID`) VALUES (320, 'Available', 32, 'D');
INSERT INTO `Delivery_System`.`Drone_Details` (`Drone_ID`, `Drone_Status`, `warehouse_ID`, `Drone_Type_ID`) VALUES (321, 'Available', 44, 'E');
INSERT INTO `Delivery_System`.`Drone_Details` (`Drone_ID`, `Drone_Status`, `warehouse_ID`, `Drone_Type_ID`) VALUES (322, 'Available', 41, 'E');
INSERT INTO `Delivery_System`.`Drone_Details` (`Drone_ID`, `Drone_Status`, `warehouse_ID`, `Drone_Type_ID`) VALUES (323, 'Available', 45, 'E');
INSERT INTO `Delivery_System`.`Drone_Details` (`Drone_ID`, `Drone_Status`, `warehouse_ID`, `Drone_Type_ID`) VALUES (324, 'Available', 37, 'E');
INSERT INTO `Delivery_System`.`Drone_Details` (`Drone_ID`, `Drone_Status`, `warehouse_ID`, `Drone_Type_ID`) VALUES (325, 'Available', 33, 'E');
INSERT INTO `Delivery_System`.`Drone_Details` (`Drone_ID`, `Drone_Status`, `warehouse_ID`, `Drone_Type_ID`) VALUES (326, 'Available', 31, 'E');
INSERT INTO `Delivery_System`.`Drone_Details` (`Drone_ID`, `Drone_Status`, `warehouse_ID`, `Drone_Type_ID`) VALUES (327, 'Available', 40, 'E');
INSERT INTO `Delivery_System`.`Drone_Details` (`Drone_ID`, `Drone_Status`, `warehouse_ID`, `Drone_Type_ID`) VALUES (328, 'Available', 45, 'E');
INSERT INTO `Delivery_System`.`Drone_Details` (`Drone_ID`, `Drone_Status`, `warehouse_ID`, `Drone_Type_ID`) VALUES (329, 'Available', 36, 'E');
INSERT INTO `Delivery_System`.`Drone_Details` (`Drone_ID`, `Drone_Status`, `warehouse_ID`, `Drone_Type_ID`) VALUES (330, 'Available', 49, 'E');
INSERT INTO `Delivery_System`.`Drone_Details` (`Drone_ID`, `Drone_Status`, `warehouse_ID`, `Drone_Type_ID`) VALUES (331, 'Available', 44, 'E');
INSERT INTO `Delivery_System`.`Drone_Details` (`Drone_ID`, `Drone_Status`, `warehouse_ID`, `Drone_Type_ID`) VALUES (332, 'Available', 35, 'E');
INSERT INTO `Delivery_System`.`Drone_Details` (`Drone_ID`, `Drone_Status`, `warehouse_ID`, `Drone_Type_ID`) VALUES (333, 'Available', 40, 'E');
INSERT INTO `Delivery_System`.`Drone_Details` (`Drone_ID`, `Drone_Status`, `warehouse_ID`, `Drone_Type_ID`) VALUES (334, 'Available', 38, 'E');
INSERT INTO `Delivery_System`.`Drone_Details` (`Drone_ID`, `Drone_Status`, `warehouse_ID`, `Drone_Type_ID`) VALUES (335, 'Available', 39, 'E');
INSERT INTO `Delivery_System`.`Drone_Details` (`Drone_ID`, `Drone_Status`, `warehouse_ID`, `Drone_Type_ID`) VALUES (336, 'Available', 34, 'E');
INSERT INTO `Delivery_System`.`Drone_Details` (`Drone_ID`, `Drone_Status`, `warehouse_ID`, `Drone_Type_ID`) VALUES (337, 'Available', 35, 'E');
INSERT INTO `Delivery_System`.`Drone_Details` (`Drone_ID`, `Drone_Status`, `warehouse_ID`, `Drone_Type_ID`) VALUES (338, 'Available', 45, 'E');
INSERT INTO `Delivery_System`.`Drone_Details` (`Drone_ID`, `Drone_Status`, `warehouse_ID`, `Drone_Type_ID`) VALUES (339, 'Available', 38, 'E');
INSERT INTO `Delivery_System`.`Drone_Details` (`Drone_ID`, `Drone_Status`, `warehouse_ID`, `Drone_Type_ID`) VALUES (340, 'Available', 48, 'E');

COMMIT;


-- -----------------------------------------------------
-- Data for table `Delivery_System`.`Order_Item`
-- -----------------------------------------------------
START TRANSACTION;
USE `Delivery_System`;
INSERT INTO `Delivery_System`.`Order_Item` (`OrderItem_ID`, `OrderItem_Status`, `Order_Date`, `Package_weight`, `Serial_No`, `Drone_ID`, `Customer_Cust_ID`) VALUES (100101, 'Order Delivered', '12/10/2012', 3.89, 484781, 12, 5);
INSERT INTO `Delivery_System`.`Order_Item` (`OrderItem_ID`, `OrderItem_Status`, `Order_Date`, `Package_weight`, `Serial_No`, `Drone_ID`, `Customer_Cust_ID`) VALUES (100102, 'Order Delivered', '12/21/2012', 30.23, 484782, 226, 10);
INSERT INTO `Delivery_System`.`Order_Item` (`OrderItem_ID`, `OrderItem_Status`, `Order_Date`, `Package_weight`, `Serial_No`, `Drone_ID`, `Customer_Cust_ID`) VALUES (100103, 'Order Delivered', '12/22/2012', 2.84, 484783, 111, 59);
INSERT INTO `Delivery_System`.`Order_Item` (`OrderItem_ID`, `OrderItem_Status`, `Order_Date`, `Package_weight`, `Serial_No`, `Drone_ID`, `Customer_Cust_ID`) VALUES (100104, 'Order Delivered', '12/24/2012', 17.65, 484784, 165, 26);
INSERT INTO `Delivery_System`.`Order_Item` (`OrderItem_ID`, `OrderItem_Status`, `Order_Date`, `Package_weight`, `Serial_No`, `Drone_ID`, `Customer_Cust_ID`) VALUES (100105, 'Order Delivered', '12/25/2012', 48.69, 484785, 290, 94);
INSERT INTO `Delivery_System`.`Order_Item` (`OrderItem_ID`, `OrderItem_Status`, `Order_Date`, `Package_weight`, `Serial_No`, `Drone_ID`, `Customer_Cust_ID`) VALUES (100106, 'Order Delivered', '12/27/2012', 2.29, 484786, 86, 65);
INSERT INTO `Delivery_System`.`Order_Item` (`OrderItem_ID`, `OrderItem_Status`, `Order_Date`, `Package_weight`, `Serial_No`, `Drone_ID`, `Customer_Cust_ID`) VALUES (100107, 'Order Delivered', '1/9/2013', 11.48, 484787, 206, 87);
INSERT INTO `Delivery_System`.`Order_Item` (`OrderItem_ID`, `OrderItem_Status`, `Order_Date`, `Package_weight`, `Serial_No`, `Drone_ID`, `Customer_Cust_ID`) VALUES (100108, 'Order Delivered', '1/10/2013', 63.63, 484788, 333, 45);
INSERT INTO `Delivery_System`.`Order_Item` (`OrderItem_ID`, `OrderItem_Status`, `Order_Date`, `Package_weight`, `Serial_No`, `Drone_ID`, `Customer_Cust_ID`) VALUES (100109, 'Order Delivered', '1/24/2013', 33.16, 484789, 279, 45);
INSERT INTO `Delivery_System`.`Order_Item` (`OrderItem_ID`, `OrderItem_Status`, `Order_Date`, `Package_weight`, `Serial_No`, `Drone_ID`, `Customer_Cust_ID`) VALUES (100110, 'Order Delivered', '2/4/2013', 60.86, 484790, 326, 97);
INSERT INTO `Delivery_System`.`Order_Item` (`OrderItem_ID`, `OrderItem_Status`, `Order_Date`, `Package_weight`, `Serial_No`, `Drone_ID`, `Customer_Cust_ID`) VALUES (100111, 'Order Delivered', '2/12/2013', 59.04, 484791, 327, 100);
INSERT INTO `Delivery_System`.`Order_Item` (`OrderItem_ID`, `OrderItem_Status`, `Order_Date`, `Package_weight`, `Serial_No`, `Drone_ID`, `Customer_Cust_ID`) VALUES (100112, 'Order Delivered', '2/24/2013', 4.91, 484792, 9, 45);
INSERT INTO `Delivery_System`.`Order_Item` (`OrderItem_ID`, `OrderItem_Status`, `Order_Date`, `Package_weight`, `Serial_No`, `Drone_ID`, `Customer_Cust_ID`) VALUES (100113, 'Order Delivered', '2/27/2013', 26.15, 484793, 250, 65);
INSERT INTO `Delivery_System`.`Order_Item` (`OrderItem_ID`, `OrderItem_Status`, `Order_Date`, `Package_weight`, `Serial_No`, `Drone_ID`, `Customer_Cust_ID`) VALUES (100114, 'Order Delivered', '3/8/2013', 19.81, 484794, 200, 1);
INSERT INTO `Delivery_System`.`Order_Item` (`OrderItem_ID`, `OrderItem_Status`, `Order_Date`, `Package_weight`, `Serial_No`, `Drone_ID`, `Customer_Cust_ID`) VALUES (100115, 'Order Delivered', '3/12/2013', 7.42, 484795, 189, 21);
INSERT INTO `Delivery_System`.`Order_Item` (`OrderItem_ID`, `OrderItem_Status`, `Order_Date`, `Package_weight`, `Serial_No`, `Drone_ID`, `Customer_Cust_ID`) VALUES (100116, 'Order Delivered', '3/26/2013', 41.58, 484796, 296, 48);
INSERT INTO `Delivery_System`.`Order_Item` (`OrderItem_ID`, `OrderItem_Status`, `Order_Date`, `Package_weight`, `Serial_No`, `Drone_ID`, `Customer_Cust_ID`) VALUES (100117, 'Order Delivered', '4/2/2013', 40.81, 484797, 317, 12);
INSERT INTO `Delivery_System`.`Order_Item` (`OrderItem_ID`, `OrderItem_Status`, `Order_Date`, `Package_weight`, `Serial_No`, `Drone_ID`, `Customer_Cust_ID`) VALUES (100118, 'Order Delivered', '4/4/2013', 1.88, 484798, 98, 15);
INSERT INTO `Delivery_System`.`Order_Item` (`OrderItem_ID`, `OrderItem_Status`, `Order_Date`, `Package_weight`, `Serial_No`, `Drone_ID`, `Customer_Cust_ID`) VALUES (100119, 'Order Delivered', '4/11/2013', 12.93, 484799, 216, 48);
INSERT INTO `Delivery_System`.`Order_Item` (`OrderItem_ID`, `OrderItem_Status`, `Order_Date`, `Package_weight`, `Serial_No`, `Drone_ID`, `Customer_Cust_ID`) VALUES (100120, 'Order Delivered', '4/12/2013', 28.05, 484800, 274, 48);
INSERT INTO `Delivery_System`.`Order_Item` (`OrderItem_ID`, `OrderItem_Status`, `Order_Date`, `Package_weight`, `Serial_No`, `Drone_ID`, `Customer_Cust_ID`) VALUES (100121, 'Order Delivered', '4/13/2013', 33.28, 484801, 265, 25);
INSERT INTO `Delivery_System`.`Order_Item` (`OrderItem_ID`, `OrderItem_Status`, `Order_Date`, `Package_weight`, `Serial_No`, `Drone_ID`, `Customer_Cust_ID`) VALUES (100122, 'Order Delivered', '4/28/2013', 1.02, 484802, 56, 76);
INSERT INTO `Delivery_System`.`Order_Item` (`OrderItem_ID`, `OrderItem_Status`, `Order_Date`, `Package_weight`, `Serial_No`, `Drone_ID`, `Customer_Cust_ID`) VALUES (100123, 'Order Delivered', '4/29/2013', 47.49, 484803, 296, 89);
INSERT INTO `Delivery_System`.`Order_Item` (`OrderItem_ID`, `OrderItem_Status`, `Order_Date`, `Package_weight`, `Serial_No`, `Drone_ID`, `Customer_Cust_ID`) VALUES (100124, 'Order Delivered', '5/28/2013', 23.56, 484804, 164, 15);
INSERT INTO `Delivery_System`.`Order_Item` (`OrderItem_ID`, `OrderItem_Status`, `Order_Date`, `Package_weight`, `Serial_No`, `Drone_ID`, `Customer_Cust_ID`) VALUES (100125, 'Order Delivered', '5/28/2013', 49.99, 484805, 297, 46);
INSERT INTO `Delivery_System`.`Order_Item` (`OrderItem_ID`, `OrderItem_Status`, `Order_Date`, `Package_weight`, `Serial_No`, `Drone_ID`, `Customer_Cust_ID`) VALUES (100126, 'Order Delivered', '6/4/2013', 63.32, 484806, 322, 45);
INSERT INTO `Delivery_System`.`Order_Item` (`OrderItem_ID`, `OrderItem_Status`, `Order_Date`, `Package_weight`, `Serial_No`, `Drone_ID`, `Customer_Cust_ID`) VALUES (100127, 'Order Delivered', '7/2/2013', 51.46, 484807, 291, 7);
INSERT INTO `Delivery_System`.`Order_Item` (`OrderItem_ID`, `OrderItem_Status`, `Order_Date`, `Package_weight`, `Serial_No`, `Drone_ID`, `Customer_Cust_ID`) VALUES (100128, 'Order Delivered', '7/23/2013', 22.09, 484808, 246, 56);
INSERT INTO `Delivery_System`.`Order_Item` (`OrderItem_ID`, `OrderItem_Status`, `Order_Date`, `Package_weight`, `Serial_No`, `Drone_ID`, `Customer_Cust_ID`) VALUES (100129, 'Order Delivered', '7/25/2013', 41.77, 484809, 249, 4);
INSERT INTO `Delivery_System`.`Order_Item` (`OrderItem_ID`, `OrderItem_Status`, `Order_Date`, `Package_weight`, `Serial_No`, `Drone_ID`, `Customer_Cust_ID`) VALUES (100130, 'Order Delivered', '8/10/2013', 20.68, 484810, 229, 79);
INSERT INTO `Delivery_System`.`Order_Item` (`OrderItem_ID`, `OrderItem_Status`, `Order_Date`, `Package_weight`, `Serial_No`, `Drone_ID`, `Customer_Cust_ID`) VALUES (100131, 'Order Delivered', '8/14/2013', 20.37, 484811, 236, 79);
INSERT INTO `Delivery_System`.`Order_Item` (`OrderItem_ID`, `OrderItem_Status`, `Order_Date`, `Package_weight`, `Serial_No`, `Drone_ID`, `Customer_Cust_ID`) VALUES (100132, 'Order Delivered', '8/19/2013', 30.43, 484812, 248, 7);
INSERT INTO `Delivery_System`.`Order_Item` (`OrderItem_ID`, `OrderItem_Status`, `Order_Date`, `Package_weight`, `Serial_No`, `Drone_ID`, `Customer_Cust_ID`) VALUES (100133, 'Order Delivered', '8/20/2013', 52.57, 484813, 329, 62);
INSERT INTO `Delivery_System`.`Order_Item` (`OrderItem_ID`, `OrderItem_Status`, `Order_Date`, `Package_weight`, `Serial_No`, `Drone_ID`, `Customer_Cust_ID`) VALUES (100134, 'Order Delivered', '9/6/2013', 21.47, 484814, 256, 3);
INSERT INTO `Delivery_System`.`Order_Item` (`OrderItem_ID`, `OrderItem_Status`, `Order_Date`, `Package_weight`, `Serial_No`, `Drone_ID`, `Customer_Cust_ID`) VALUES (100135, 'Order Delivered', '9/15/2013', 40.42, 484815, 293, 2);
INSERT INTO `Delivery_System`.`Order_Item` (`OrderItem_ID`, `OrderItem_Status`, `Order_Date`, `Package_weight`, `Serial_No`, `Drone_ID`, `Customer_Cust_ID`) VALUES (100136, 'Order Delivered', '9/19/2013', 27.4, 484816, 264, 48);
INSERT INTO `Delivery_System`.`Order_Item` (`OrderItem_ID`, `OrderItem_Status`, `Order_Date`, `Package_weight`, `Serial_No`, `Drone_ID`, `Customer_Cust_ID`) VALUES (100137, 'Order Delivered', '9/20/2013', 17.33, 484817, 143, 59);
INSERT INTO `Delivery_System`.`Order_Item` (`OrderItem_ID`, `OrderItem_Status`, `Order_Date`, `Package_weight`, `Serial_No`, `Drone_ID`, `Customer_Cust_ID`) VALUES (100138, 'Order Delivered', '9/21/2013', 57.23, 484818, 336, 56);
INSERT INTO `Delivery_System`.`Order_Item` (`OrderItem_ID`, `OrderItem_Status`, `Order_Date`, `Package_weight`, `Serial_No`, `Drone_ID`, `Customer_Cust_ID`) VALUES (100139, 'Order Delivered', '9/28/2013', 27.89, 484819, 279, 62);
INSERT INTO `Delivery_System`.`Order_Item` (`OrderItem_ID`, `OrderItem_Status`, `Order_Date`, `Package_weight`, `Serial_No`, `Drone_ID`, `Customer_Cust_ID`) VALUES (100140, 'Order Delivered', '10/8/2013', 50.88, 484820, 311, 45);
INSERT INTO `Delivery_System`.`Order_Item` (`OrderItem_ID`, `OrderItem_Status`, `Order_Date`, `Package_weight`, `Serial_No`, `Drone_ID`, `Customer_Cust_ID`) VALUES (100141, 'Order Delivered', '10/10/2013', 33.4, 484821, 272, 21);
INSERT INTO `Delivery_System`.`Order_Item` (`OrderItem_ID`, `OrderItem_Status`, `Order_Date`, `Package_weight`, `Serial_No`, `Drone_ID`, `Customer_Cust_ID`) VALUES (100142, 'Order Delivered', '10/12/2013', 3.17, 484822, 56, 5);
INSERT INTO `Delivery_System`.`Order_Item` (`OrderItem_ID`, `OrderItem_Status`, `Order_Date`, `Package_weight`, `Serial_No`, `Drone_ID`, `Customer_Cust_ID`) VALUES (100143, 'Order Delivered', '10/14/2013', 3.71, 484823, 87, 78);
INSERT INTO `Delivery_System`.`Order_Item` (`OrderItem_ID`, `OrderItem_Status`, `Order_Date`, `Package_weight`, `Serial_No`, `Drone_ID`, `Customer_Cust_ID`) VALUES (100144, 'Order Delivered', '10/16/2013', 10.43, 484824, 213, 100);
INSERT INTO `Delivery_System`.`Order_Item` (`OrderItem_ID`, `OrderItem_Status`, `Order_Date`, `Package_weight`, `Serial_No`, `Drone_ID`, `Customer_Cust_ID`) VALUES (100145, 'Order Delivered', '10/29/2013', 1.74, 484825, 99, 99);
INSERT INTO `Delivery_System`.`Order_Item` (`OrderItem_ID`, `OrderItem_Status`, `Order_Date`, `Package_weight`, `Serial_No`, `Drone_ID`, `Customer_Cust_ID`) VALUES (100146, 'Order Delivered', '11/2/2013', 4.87, 484826, 88, 52);
INSERT INTO `Delivery_System`.`Order_Item` (`OrderItem_ID`, `OrderItem_Status`, `Order_Date`, `Package_weight`, `Serial_No`, `Drone_ID`, `Customer_Cust_ID`) VALUES (100147, 'Order Delivered', '11/2/2013', 3.27, 484827, 72, 32);
INSERT INTO `Delivery_System`.`Order_Item` (`OrderItem_ID`, `OrderItem_Status`, `Order_Date`, `Package_weight`, `Serial_No`, `Drone_ID`, `Customer_Cust_ID`) VALUES (100148, 'Order Delivered', '11/15/2013', 3.99, 484828, 61, 79);
INSERT INTO `Delivery_System`.`Order_Item` (`OrderItem_ID`, `OrderItem_Status`, `Order_Date`, `Package_weight`, `Serial_No`, `Drone_ID`, `Customer_Cust_ID`) VALUES (100149, 'Order Delivered', '12/20/2013', 23.67, 484829, 243, 8);
INSERT INTO `Delivery_System`.`Order_Item` (`OrderItem_ID`, `OrderItem_Status`, `Order_Date`, `Package_weight`, `Serial_No`, `Drone_ID`, `Customer_Cust_ID`) VALUES (100150, 'Order Delivered', '12/27/2013', 31.95, 484830, 251, 46);
INSERT INTO `Delivery_System`.`Order_Item` (`OrderItem_ID`, `OrderItem_Status`, `Order_Date`, `Package_weight`, `Serial_No`, `Drone_ID`, `Customer_Cust_ID`) VALUES (100151, 'Order Delivered', '12/29/2013', 4.27, 484831, 95, 46);
INSERT INTO `Delivery_System`.`Order_Item` (`OrderItem_ID`, `OrderItem_Status`, `Order_Date`, `Package_weight`, `Serial_No`, `Drone_ID`, `Customer_Cust_ID`) VALUES (100152, 'Order Delivered', '12/31/2013', 1.17, 484832, 4, 34);
INSERT INTO `Delivery_System`.`Order_Item` (`OrderItem_ID`, `OrderItem_Status`, `Order_Date`, `Package_weight`, `Serial_No`, `Drone_ID`, `Customer_Cust_ID`) VALUES (100153, 'Order Delivered', '1/14/2014', 46.7, 484833, 293, 68);
INSERT INTO `Delivery_System`.`Order_Item` (`OrderItem_ID`, `OrderItem_Status`, `Order_Date`, `Package_weight`, `Serial_No`, `Drone_ID`, `Customer_Cust_ID`) VALUES (100154, 'Order Delivered', '1/20/2014', 63.06, 484834, 338, 6);
INSERT INTO `Delivery_System`.`Order_Item` (`OrderItem_ID`, `OrderItem_Status`, `Order_Date`, `Package_weight`, `Serial_No`, `Drone_ID`, `Customer_Cust_ID`) VALUES (100155, 'Order Delivered', '1/27/2014', 1.49, 484835, 84, 9);
INSERT INTO `Delivery_System`.`Order_Item` (`OrderItem_ID`, `OrderItem_Status`, `Order_Date`, `Package_weight`, `Serial_No`, `Drone_ID`, `Customer_Cust_ID`) VALUES (100156, 'Order Delivered', '1/29/2014', 55.1, 484836, 333, 87);
INSERT INTO `Delivery_System`.`Order_Item` (`OrderItem_ID`, `OrderItem_Status`, `Order_Date`, `Package_weight`, `Serial_No`, `Drone_ID`, `Customer_Cust_ID`) VALUES (100157, 'Order Delivered', '2/3/2014', 17.32, 484837, 128, 16);
INSERT INTO `Delivery_System`.`Order_Item` (`OrderItem_ID`, `OrderItem_Status`, `Order_Date`, `Package_weight`, `Serial_No`, `Drone_ID`, `Customer_Cust_ID`) VALUES (100158, 'Order Delivered', '2/14/2014', 2.81, 484838, 96, 46);
INSERT INTO `Delivery_System`.`Order_Item` (`OrderItem_ID`, `OrderItem_Status`, `Order_Date`, `Package_weight`, `Serial_No`, `Drone_ID`, `Customer_Cust_ID`) VALUES (100159, 'Order Delivered', '2/15/2014', 55.65, 484839, 340, 85);
INSERT INTO `Delivery_System`.`Order_Item` (`OrderItem_ID`, `OrderItem_Status`, `Order_Date`, `Package_weight`, `Serial_No`, `Drone_ID`, `Customer_Cust_ID`) VALUES (100160, 'Order Delivered', '3/25/2014', 45.44, 484840, 296, 20);
INSERT INTO `Delivery_System`.`Order_Item` (`OrderItem_ID`, `OrderItem_Status`, `Order_Date`, `Package_weight`, `Serial_No`, `Drone_ID`, `Customer_Cust_ID`) VALUES (100161, 'Order Delivered', '3/25/2014', 18.56, 484841, 169, 48);
INSERT INTO `Delivery_System`.`Order_Item` (`OrderItem_ID`, `OrderItem_Status`, `Order_Date`, `Package_weight`, `Serial_No`, `Drone_ID`, `Customer_Cust_ID`) VALUES (100162, 'Order Delivered', '4/8/2014', 3.67, 484842, 84, 45);
INSERT INTO `Delivery_System`.`Order_Item` (`OrderItem_ID`, `OrderItem_Status`, `Order_Date`, `Package_weight`, `Serial_No`, `Drone_ID`, `Customer_Cust_ID`) VALUES (100163, 'Order Delivered', '4/14/2014', 37.15, 484843, 296, 56);
INSERT INTO `Delivery_System`.`Order_Item` (`OrderItem_ID`, `OrderItem_Status`, `Order_Date`, `Package_weight`, `Serial_No`, `Drone_ID`, `Customer_Cust_ID`) VALUES (100164, 'Order Delivered', '5/15/2014', 29.44, 484844, 242, 1);
INSERT INTO `Delivery_System`.`Order_Item` (`OrderItem_ID`, `OrderItem_Status`, `Order_Date`, `Package_weight`, `Serial_No`, `Drone_ID`, `Customer_Cust_ID`) VALUES (100165, 'Order Delivered', '5/19/2014', 1.06, 484845, 59, 89);
INSERT INTO `Delivery_System`.`Order_Item` (`OrderItem_ID`, `OrderItem_Status`, `Order_Date`, `Package_weight`, `Serial_No`, `Drone_ID`, `Customer_Cust_ID`) VALUES (100166, 'Order Delivered', '5/22/2014', 47.32, 484846, 289, 100);
INSERT INTO `Delivery_System`.`Order_Item` (`OrderItem_ID`, `OrderItem_Status`, `Order_Date`, `Package_weight`, `Serial_No`, `Drone_ID`, `Customer_Cust_ID`) VALUES (100167, 'Order Delivered', '6/22/2014', 40.74, 484847, 296, 4);
INSERT INTO `Delivery_System`.`Order_Item` (`OrderItem_ID`, `OrderItem_Status`, `Order_Date`, `Package_weight`, `Serial_No`, `Drone_ID`, `Customer_Cust_ID`) VALUES (100168, 'Order Delivered', '6/27/2014', 42.21, 484848, 292, 89);
INSERT INTO `Delivery_System`.`Order_Item` (`OrderItem_ID`, `OrderItem_Status`, `Order_Date`, `Package_weight`, `Serial_No`, `Drone_ID`, `Customer_Cust_ID`) VALUES (100169, 'Order Delivered', '7/15/2014', 44.02, 484849, 312, 46);
INSERT INTO `Delivery_System`.`Order_Item` (`OrderItem_ID`, `OrderItem_Status`, `Order_Date`, `Package_weight`, `Serial_No`, `Drone_ID`, `Customer_Cust_ID`) VALUES (100170, 'Order Delivered', '8/9/2014', 4.44, 484850, 14, 84);
INSERT INTO `Delivery_System`.`Order_Item` (`OrderItem_ID`, `OrderItem_Status`, `Order_Date`, `Package_weight`, `Serial_No`, `Drone_ID`, `Customer_Cust_ID`) VALUES (100171, 'Order Delivered', '9/2/2014', 13.11, 484851, 152, 16);
INSERT INTO `Delivery_System`.`Order_Item` (`OrderItem_ID`, `OrderItem_Status`, `Order_Date`, `Package_weight`, `Serial_No`, `Drone_ID`, `Customer_Cust_ID`) VALUES (100172, 'Order Delivered', '9/3/2014', 9.27, 484852, 125, 89);
INSERT INTO `Delivery_System`.`Order_Item` (`OrderItem_ID`, `OrderItem_Status`, `Order_Date`, `Package_weight`, `Serial_No`, `Drone_ID`, `Customer_Cust_ID`) VALUES (100173, 'Order Delivered', '9/4/2014', 46.53, 484853, 292, 78);
INSERT INTO `Delivery_System`.`Order_Item` (`OrderItem_ID`, `OrderItem_Status`, `Order_Date`, `Package_weight`, `Serial_No`, `Drone_ID`, `Customer_Cust_ID`) VALUES (100174, 'Order Delivered', '9/5/2014', 38.12, 484854, 283, 48);
INSERT INTO `Delivery_System`.`Order_Item` (`OrderItem_ID`, `OrderItem_Status`, `Order_Date`, `Package_weight`, `Serial_No`, `Drone_ID`, `Customer_Cust_ID`) VALUES (100175, 'Order Delivered', '9/21/2014', 1.14, 484855, 10, 45);
INSERT INTO `Delivery_System`.`Order_Item` (`OrderItem_ID`, `OrderItem_Status`, `Order_Date`, `Package_weight`, `Serial_No`, `Drone_ID`, `Customer_Cust_ID`) VALUES (100176, 'Order Delivered', '9/25/2014', 45.98, 484856, 289, 84);
INSERT INTO `Delivery_System`.`Order_Item` (`OrderItem_ID`, `OrderItem_Status`, `Order_Date`, `Package_weight`, `Serial_No`, `Drone_ID`, `Customer_Cust_ID`) VALUES (100177, 'Order Delivered', '9/25/2014', 15.41, 484857, 128, 89);
INSERT INTO `Delivery_System`.`Order_Item` (`OrderItem_ID`, `OrderItem_Status`, `Order_Date`, `Package_weight`, `Serial_No`, `Drone_ID`, `Customer_Cust_ID`) VALUES (100178, 'Order Delivered', '9/28/2014', 0.77, 484858, 3, 50);
INSERT INTO `Delivery_System`.`Order_Item` (`OrderItem_ID`, `OrderItem_Status`, `Order_Date`, `Package_weight`, `Serial_No`, `Drone_ID`, `Customer_Cust_ID`) VALUES (100179, 'Order Delivered', '10/21/2014', 3.71, 484859, 89, 90);
INSERT INTO `Delivery_System`.`Order_Item` (`OrderItem_ID`, `OrderItem_Status`, `Order_Date`, `Package_weight`, `Serial_No`, `Drone_ID`, `Customer_Cust_ID`) VALUES (100180, 'Order Delivered', '10/22/2014', 18.02, 484860, 142, 78);
INSERT INTO `Delivery_System`.`Order_Item` (`OrderItem_ID`, `OrderItem_Status`, `Order_Date`, `Package_weight`, `Serial_No`, `Drone_ID`, `Customer_Cust_ID`) VALUES (100181, 'Order Delivered', '10/23/2014', 4.43, 484861, 5, 13);
INSERT INTO `Delivery_System`.`Order_Item` (`OrderItem_ID`, `OrderItem_Status`, `Order_Date`, `Package_weight`, `Serial_No`, `Drone_ID`, `Customer_Cust_ID`) VALUES (100182, 'Order Delivered', '11/15/2014', 25.1, 484862, 269, 79);
INSERT INTO `Delivery_System`.`Order_Item` (`OrderItem_ID`, `OrderItem_Status`, `Order_Date`, `Package_weight`, `Serial_No`, `Drone_ID`, `Customer_Cust_ID`) VALUES (100183, 'Order Delivered', '11/18/2014', 63.34, 484863, 338, 5);
INSERT INTO `Delivery_System`.`Order_Item` (`OrderItem_ID`, `OrderItem_Status`, `Order_Date`, `Package_weight`, `Serial_No`, `Drone_ID`, `Customer_Cust_ID`) VALUES (100184, 'Order Delivered', '11/28/2014', 10.27, 484864, 224, 84);
INSERT INTO `Delivery_System`.`Order_Item` (`OrderItem_ID`, `OrderItem_Status`, `Order_Date`, `Package_weight`, `Serial_No`, `Drone_ID`, `Customer_Cust_ID`) VALUES (100185, 'Order Delivered', '1/7/2015', 36.17, 484865, 295, 87);
INSERT INTO `Delivery_System`.`Order_Item` (`OrderItem_ID`, `OrderItem_Status`, `Order_Date`, `Package_weight`, `Serial_No`, `Drone_ID`, `Customer_Cust_ID`) VALUES (100186, 'Order Delivered', '1/8/2015', 61.08, 484866, 333, 64);
INSERT INTO `Delivery_System`.`Order_Item` (`OrderItem_ID`, `OrderItem_Status`, `Order_Date`, `Package_weight`, `Serial_No`, `Drone_ID`, `Customer_Cust_ID`) VALUES (100187, 'Order Delivered', '1/9/2015', 63.77, 484867, 339, 87);
INSERT INTO `Delivery_System`.`Order_Item` (`OrderItem_ID`, `OrderItem_Status`, `Order_Date`, `Package_weight`, `Serial_No`, `Drone_ID`, `Customer_Cust_ID`) VALUES (100188, 'Order Delivered', '4/18/2015', 18.32, 484868, 165, 78);
INSERT INTO `Delivery_System`.`Order_Item` (`OrderItem_ID`, `OrderItem_Status`, `Order_Date`, `Package_weight`, `Serial_No`, `Drone_ID`, `Customer_Cust_ID`) VALUES (100189, 'Order Delivered', '4/23/2015', 54.73, 484869, 300, 13);
INSERT INTO `Delivery_System`.`Order_Item` (`OrderItem_ID`, `OrderItem_Status`, `Order_Date`, `Package_weight`, `Serial_No`, `Drone_ID`, `Customer_Cust_ID`) VALUES (100190, 'Order Delivered', '4/25/2015', 60.05, 484870, 310, 79);
INSERT INTO `Delivery_System`.`Order_Item` (`OrderItem_ID`, `OrderItem_Status`, `Order_Date`, `Package_weight`, `Serial_No`, `Drone_ID`, `Customer_Cust_ID`) VALUES (100191, 'Order InProcess', '4/26/2015', 2.52, 484871, 11, 5);
INSERT INTO `Delivery_System`.`Order_Item` (`OrderItem_ID`, `OrderItem_Status`, `Order_Date`, `Package_weight`, `Serial_No`, `Drone_ID`, `Customer_Cust_ID`) VALUES (100192, 'Order InProcess', '4/26/2015', 4.5, 484872, 56, 64);
INSERT INTO `Delivery_System`.`Order_Item` (`OrderItem_ID`, `OrderItem_Status`, `Order_Date`, `Package_weight`, `Serial_No`, `Drone_ID`, `Customer_Cust_ID`) VALUES (100193, 'Order InProcess', '4/26/2015', 3.9, 484873, 89, 79);
INSERT INTO `Delivery_System`.`Order_Item` (`OrderItem_ID`, `OrderItem_Status`, `Order_Date`, `Package_weight`, `Serial_No`, `Drone_ID`, `Customer_Cust_ID`) VALUES (100194, 'Order InProcess', '4/26/2015', 1.21, 484874, 112, 8);
INSERT INTO `Delivery_System`.`Order_Item` (`OrderItem_ID`, `OrderItem_Status`, `Order_Date`, `Package_weight`, `Serial_No`, `Drone_ID`, `Customer_Cust_ID`) VALUES (100195, 'Order InProcess', '4/26/2015', 4.35, 484875, 78, 12);
INSERT INTO `Delivery_System`.`Order_Item` (`OrderItem_ID`, `OrderItem_Status`, `Order_Date`, `Package_weight`, `Serial_No`, `Drone_ID`, `Customer_Cust_ID`) VALUES (100196, 'Order InProcess', '4/26/2015', 13.04, 484876, 163, 45);
INSERT INTO `Delivery_System`.`Order_Item` (`OrderItem_ID`, `OrderItem_Status`, `Order_Date`, `Package_weight`, `Serial_No`, `Drone_ID`, `Customer_Cust_ID`) VALUES (100197, 'Order InProcess', '4/26/2015', 18.68, 484877, 146, 86);
INSERT INTO `Delivery_System`.`Order_Item` (`OrderItem_ID`, `OrderItem_Status`, `Order_Date`, `Package_weight`, `Serial_No`, `Drone_ID`, `Customer_Cust_ID`) VALUES (100198, 'Order InProcess', '4/26/2015', 24.41, 484878, 236, 47);
INSERT INTO `Delivery_System`.`Order_Item` (`OrderItem_ID`, `OrderItem_Status`, `Order_Date`, `Package_weight`, `Serial_No`, `Drone_ID`, `Customer_Cust_ID`) VALUES (100199, 'Order InProcess', '4/26/2015', 33.5, 484879, 271, 46);
INSERT INTO `Delivery_System`.`Order_Item` (`OrderItem_ID`, `OrderItem_Status`, `Order_Date`, `Package_weight`, `Serial_No`, `Drone_ID`, `Customer_Cust_ID`) VALUES (100200, 'Order InProcess', '4/26/2015', 45.56, 484880, 311, 7);

COMMIT;


-- -----------------------------------------------------
-- Data for table `Delivery_System`.`Phone`
-- -----------------------------------------------------
START TRANSACTION;
USE `Delivery_System`;
INSERT INTO `Delivery_System`.`Phone` (`Phone_ID`, `Number`, `Cust_ID`) VALUES (1, '1-404-817-6419', 1);
INSERT INTO `Delivery_System`.`Phone` (`Phone_ID`, `Number`, `Cust_ID`) VALUES (2, '1-133-630-4086', 2);
INSERT INTO `Delivery_System`.`Phone` (`Phone_ID`, `Number`, `Cust_ID`) VALUES (3, '1-643-712-3952', 3);
INSERT INTO `Delivery_System`.`Phone` (`Phone_ID`, `Number`, `Cust_ID`) VALUES (4, '1-951-218-0583', 4);
INSERT INTO `Delivery_System`.`Phone` (`Phone_ID`, `Number`, `Cust_ID`) VALUES (5, '1-281-897-2438', 5);
INSERT INTO `Delivery_System`.`Phone` (`Phone_ID`, `Number`, `Cust_ID`) VALUES (6, '1-892-287-8699', 6);
INSERT INTO `Delivery_System`.`Phone` (`Phone_ID`, `Number`, `Cust_ID`) VALUES (7, '1-694-626-9813', 7);
INSERT INTO `Delivery_System`.`Phone` (`Phone_ID`, `Number`, `Cust_ID`) VALUES (8, '1-397-640-0899', 8);
INSERT INTO `Delivery_System`.`Phone` (`Phone_ID`, `Number`, `Cust_ID`) VALUES (9, '1-532-995-3405', 9);
INSERT INTO `Delivery_System`.`Phone` (`Phone_ID`, `Number`, `Cust_ID`) VALUES (10, '1-627-482-2043', 10);
INSERT INTO `Delivery_System`.`Phone` (`Phone_ID`, `Number`, `Cust_ID`) VALUES (11, '1-861-347-7770', 11);
INSERT INTO `Delivery_System`.`Phone` (`Phone_ID`, `Number`, `Cust_ID`) VALUES (12, '1-304-242-6588', 12);
INSERT INTO `Delivery_System`.`Phone` (`Phone_ID`, `Number`, `Cust_ID`) VALUES (13, '1-478-434-6710', 13);
INSERT INTO `Delivery_System`.`Phone` (`Phone_ID`, `Number`, `Cust_ID`) VALUES (14, '1-583-303-5116', 14);
INSERT INTO `Delivery_System`.`Phone` (`Phone_ID`, `Number`, `Cust_ID`) VALUES (15, '1-546-734-0381', 15);
INSERT INTO `Delivery_System`.`Phone` (`Phone_ID`, `Number`, `Cust_ID`) VALUES (16, '1-455-851-8984', 16);
INSERT INTO `Delivery_System`.`Phone` (`Phone_ID`, `Number`, `Cust_ID`) VALUES (17, '1-327-404-8254', 17);
INSERT INTO `Delivery_System`.`Phone` (`Phone_ID`, `Number`, `Cust_ID`) VALUES (18, '1-262-982-6512', 18);
INSERT INTO `Delivery_System`.`Phone` (`Phone_ID`, `Number`, `Cust_ID`) VALUES (19, '1-775-675-9387', 19);
INSERT INTO `Delivery_System`.`Phone` (`Phone_ID`, `Number`, `Cust_ID`) VALUES (20, '1-401-208-2332', 20);
INSERT INTO `Delivery_System`.`Phone` (`Phone_ID`, `Number`, `Cust_ID`) VALUES (21, '1-922-444-6010', 21);
INSERT INTO `Delivery_System`.`Phone` (`Phone_ID`, `Number`, `Cust_ID`) VALUES (22, '1-466-686-1120', 22);
INSERT INTO `Delivery_System`.`Phone` (`Phone_ID`, `Number`, `Cust_ID`) VALUES (23, '1-333-895-4050', 23);
INSERT INTO `Delivery_System`.`Phone` (`Phone_ID`, `Number`, `Cust_ID`) VALUES (24, '1-943-457-8877', 24);
INSERT INTO `Delivery_System`.`Phone` (`Phone_ID`, `Number`, `Cust_ID`) VALUES (25, '1-154-779-9195', 25);
INSERT INTO `Delivery_System`.`Phone` (`Phone_ID`, `Number`, `Cust_ID`) VALUES (26, '1-197-234-0375', 26);
INSERT INTO `Delivery_System`.`Phone` (`Phone_ID`, `Number`, `Cust_ID`) VALUES (27, '1-146-940-8374', 27);
INSERT INTO `Delivery_System`.`Phone` (`Phone_ID`, `Number`, `Cust_ID`) VALUES (28, '1-984-744-2685', 28);
INSERT INTO `Delivery_System`.`Phone` (`Phone_ID`, `Number`, `Cust_ID`) VALUES (29, '1-698-197-8821', 29);
INSERT INTO `Delivery_System`.`Phone` (`Phone_ID`, `Number`, `Cust_ID`) VALUES (30, '1-711-401-0354', 30);
INSERT INTO `Delivery_System`.`Phone` (`Phone_ID`, `Number`, `Cust_ID`) VALUES (31, '1-349-857-1066', 31);
INSERT INTO `Delivery_System`.`Phone` (`Phone_ID`, `Number`, `Cust_ID`) VALUES (32, '1-164-857-1539', 32);
INSERT INTO `Delivery_System`.`Phone` (`Phone_ID`, `Number`, `Cust_ID`) VALUES (33, '1-831-547-0322', 33);
INSERT INTO `Delivery_System`.`Phone` (`Phone_ID`, `Number`, `Cust_ID`) VALUES (34, '1-626-443-4865', 34);
INSERT INTO `Delivery_System`.`Phone` (`Phone_ID`, `Number`, `Cust_ID`) VALUES (35, '1-248-227-7511', 35);
INSERT INTO `Delivery_System`.`Phone` (`Phone_ID`, `Number`, `Cust_ID`) VALUES (36, '1-267-668-7221', 36);
INSERT INTO `Delivery_System`.`Phone` (`Phone_ID`, `Number`, `Cust_ID`) VALUES (37, '1-294-571-2557', 37);
INSERT INTO `Delivery_System`.`Phone` (`Phone_ID`, `Number`, `Cust_ID`) VALUES (38, '1-682-527-2049', 38);
INSERT INTO `Delivery_System`.`Phone` (`Phone_ID`, `Number`, `Cust_ID`) VALUES (39, '1-623-492-9826', 39);
INSERT INTO `Delivery_System`.`Phone` (`Phone_ID`, `Number`, `Cust_ID`) VALUES (40, '1-833-963-6074', 40);
INSERT INTO `Delivery_System`.`Phone` (`Phone_ID`, `Number`, `Cust_ID`) VALUES (41, '1-268-101-5515', 41);
INSERT INTO `Delivery_System`.`Phone` (`Phone_ID`, `Number`, `Cust_ID`) VALUES (42, '1-873-570-2303', 42);
INSERT INTO `Delivery_System`.`Phone` (`Phone_ID`, `Number`, `Cust_ID`) VALUES (43, '1-218-845-1100', 43);
INSERT INTO `Delivery_System`.`Phone` (`Phone_ID`, `Number`, `Cust_ID`) VALUES (44, '1-887-370-8491', 44);
INSERT INTO `Delivery_System`.`Phone` (`Phone_ID`, `Number`, `Cust_ID`) VALUES (45, '1-429-618-3030', 45);
INSERT INTO `Delivery_System`.`Phone` (`Phone_ID`, `Number`, `Cust_ID`) VALUES (46, '1-595-163-1245', 46);
INSERT INTO `Delivery_System`.`Phone` (`Phone_ID`, `Number`, `Cust_ID`) VALUES (47, '1-245-394-1619', 47);
INSERT INTO `Delivery_System`.`Phone` (`Phone_ID`, `Number`, `Cust_ID`) VALUES (48, '1-132-902-6093', 48);
INSERT INTO `Delivery_System`.`Phone` (`Phone_ID`, `Number`, `Cust_ID`) VALUES (49, '1-554-212-8875', 49);
INSERT INTO `Delivery_System`.`Phone` (`Phone_ID`, `Number`, `Cust_ID`) VALUES (50, '1-767-254-9202', 50);
INSERT INTO `Delivery_System`.`Phone` (`Phone_ID`, `Number`, `Cust_ID`) VALUES (51, '1-526-243-4381', 51);
INSERT INTO `Delivery_System`.`Phone` (`Phone_ID`, `Number`, `Cust_ID`) VALUES (52, '1-695-625-3843', 52);
INSERT INTO `Delivery_System`.`Phone` (`Phone_ID`, `Number`, `Cust_ID`) VALUES (53, '1-810-520-8579', 53);
INSERT INTO `Delivery_System`.`Phone` (`Phone_ID`, `Number`, `Cust_ID`) VALUES (54, '1-156-309-4806', 54);
INSERT INTO `Delivery_System`.`Phone` (`Phone_ID`, `Number`, `Cust_ID`) VALUES (55, '1-459-279-8286', 55);
INSERT INTO `Delivery_System`.`Phone` (`Phone_ID`, `Number`, `Cust_ID`) VALUES (56, '1-924-418-2767', 56);
INSERT INTO `Delivery_System`.`Phone` (`Phone_ID`, `Number`, `Cust_ID`) VALUES (57, '1-893-763-5963', 57);
INSERT INTO `Delivery_System`.`Phone` (`Phone_ID`, `Number`, `Cust_ID`) VALUES (58, '1-565-833-8524', 58);
INSERT INTO `Delivery_System`.`Phone` (`Phone_ID`, `Number`, `Cust_ID`) VALUES (59, '1-751-191-8632', 59);
INSERT INTO `Delivery_System`.`Phone` (`Phone_ID`, `Number`, `Cust_ID`) VALUES (60, '1-148-314-9795', 60);
INSERT INTO `Delivery_System`.`Phone` (`Phone_ID`, `Number`, `Cust_ID`) VALUES (61, '1-620-861-2584', 61);
INSERT INTO `Delivery_System`.`Phone` (`Phone_ID`, `Number`, `Cust_ID`) VALUES (62, '1-428-651-5645', 62);
INSERT INTO `Delivery_System`.`Phone` (`Phone_ID`, `Number`, `Cust_ID`) VALUES (63, '1-746-908-3001', 63);
INSERT INTO `Delivery_System`.`Phone` (`Phone_ID`, `Number`, `Cust_ID`) VALUES (64, '1-397-695-1695', 64);
INSERT INTO `Delivery_System`.`Phone` (`Phone_ID`, `Number`, `Cust_ID`) VALUES (65, '1-726-196-8200', 65);
INSERT INTO `Delivery_System`.`Phone` (`Phone_ID`, `Number`, `Cust_ID`) VALUES (66, '1-178-939-8245', 66);
INSERT INTO `Delivery_System`.`Phone` (`Phone_ID`, `Number`, `Cust_ID`) VALUES (67, '1-225-323-9816', 67);
INSERT INTO `Delivery_System`.`Phone` (`Phone_ID`, `Number`, `Cust_ID`) VALUES (68, '1-322-286-0879', 68);
INSERT INTO `Delivery_System`.`Phone` (`Phone_ID`, `Number`, `Cust_ID`) VALUES (69, '1-566-406-8650', 69);
INSERT INTO `Delivery_System`.`Phone` (`Phone_ID`, `Number`, `Cust_ID`) VALUES (70, '1-521-475-2629', 70);
INSERT INTO `Delivery_System`.`Phone` (`Phone_ID`, `Number`, `Cust_ID`) VALUES (71, '1-132-371-8686', 71);
INSERT INTO `Delivery_System`.`Phone` (`Phone_ID`, `Number`, `Cust_ID`) VALUES (72, '1-989-402-9405', 72);
INSERT INTO `Delivery_System`.`Phone` (`Phone_ID`, `Number`, `Cust_ID`) VALUES (73, '1-756-156-5351', 73);
INSERT INTO `Delivery_System`.`Phone` (`Phone_ID`, `Number`, `Cust_ID`) VALUES (74, '1-730-498-8637', 74);
INSERT INTO `Delivery_System`.`Phone` (`Phone_ID`, `Number`, `Cust_ID`) VALUES (75, '1-993-776-1335', 75);
INSERT INTO `Delivery_System`.`Phone` (`Phone_ID`, `Number`, `Cust_ID`) VALUES (76, '1-463-477-4086', 76);
INSERT INTO `Delivery_System`.`Phone` (`Phone_ID`, `Number`, `Cust_ID`) VALUES (77, '1-885-678-8064', 77);
INSERT INTO `Delivery_System`.`Phone` (`Phone_ID`, `Number`, `Cust_ID`) VALUES (78, '1-832-679-5186', 78);
INSERT INTO `Delivery_System`.`Phone` (`Phone_ID`, `Number`, `Cust_ID`) VALUES (79, '1-970-409-9416', 79);
INSERT INTO `Delivery_System`.`Phone` (`Phone_ID`, `Number`, `Cust_ID`) VALUES (80, '1-591-365-8610', 80);
INSERT INTO `Delivery_System`.`Phone` (`Phone_ID`, `Number`, `Cust_ID`) VALUES (81, '1-822-623-1736', 81);
INSERT INTO `Delivery_System`.`Phone` (`Phone_ID`, `Number`, `Cust_ID`) VALUES (82, '1-257-958-5222', 82);
INSERT INTO `Delivery_System`.`Phone` (`Phone_ID`, `Number`, `Cust_ID`) VALUES (83, '1-809-872-3019', 83);
INSERT INTO `Delivery_System`.`Phone` (`Phone_ID`, `Number`, `Cust_ID`) VALUES (84, '1-684-852-7617', 84);
INSERT INTO `Delivery_System`.`Phone` (`Phone_ID`, `Number`, `Cust_ID`) VALUES (85, '1-132-193-8522', 85);
INSERT INTO `Delivery_System`.`Phone` (`Phone_ID`, `Number`, `Cust_ID`) VALUES (86, '1-192-476-6568', 86);
INSERT INTO `Delivery_System`.`Phone` (`Phone_ID`, `Number`, `Cust_ID`) VALUES (87, '1-548-405-9206', 87);
INSERT INTO `Delivery_System`.`Phone` (`Phone_ID`, `Number`, `Cust_ID`) VALUES (88, '1-901-207-9846', 88);
INSERT INTO `Delivery_System`.`Phone` (`Phone_ID`, `Number`, `Cust_ID`) VALUES (89, '1-841-303-3062', 89);
INSERT INTO `Delivery_System`.`Phone` (`Phone_ID`, `Number`, `Cust_ID`) VALUES (90, '1-160-590-9802', 90);
INSERT INTO `Delivery_System`.`Phone` (`Phone_ID`, `Number`, `Cust_ID`) VALUES (91, '1-340-941-0345', 91);
INSERT INTO `Delivery_System`.`Phone` (`Phone_ID`, `Number`, `Cust_ID`) VALUES (92, '1-629-498-7694', 92);
INSERT INTO `Delivery_System`.`Phone` (`Phone_ID`, `Number`, `Cust_ID`) VALUES (93, '1-774-364-2114', 93);
INSERT INTO `Delivery_System`.`Phone` (`Phone_ID`, `Number`, `Cust_ID`) VALUES (94, '1-641-518-1225', 94);
INSERT INTO `Delivery_System`.`Phone` (`Phone_ID`, `Number`, `Cust_ID`) VALUES (95, '1-895-472-5616', 95);
INSERT INTO `Delivery_System`.`Phone` (`Phone_ID`, `Number`, `Cust_ID`) VALUES (96, '1-462-689-7674', 96);
INSERT INTO `Delivery_System`.`Phone` (`Phone_ID`, `Number`, `Cust_ID`) VALUES (97, '1-878-114-6021', 97);
INSERT INTO `Delivery_System`.`Phone` (`Phone_ID`, `Number`, `Cust_ID`) VALUES (98, '1-973-378-3730', 98);
INSERT INTO `Delivery_System`.`Phone` (`Phone_ID`, `Number`, `Cust_ID`) VALUES (99, '1-719-290-1027', 99);
INSERT INTO `Delivery_System`.`Phone` (`Phone_ID`, `Number`, `Cust_ID`) VALUES (100, '1-166-931-9006', 100);

COMMIT;


-- -----------------------------------------------------
-- Data for table `Delivery_System`.`Precipitation`
-- -----------------------------------------------------
START TRANSACTION;
USE `Delivery_System`;
INSERT INTO `Delivery_System`.`Precipitation` (`Precipitation_ID`, `Description`) VALUES (1, 'Drizzle');
INSERT INTO `Delivery_System`.`Precipitation` (`Precipitation_ID`, `Description`) VALUES (2, 'Rain');
INSERT INTO `Delivery_System`.`Precipitation` (`Precipitation_ID`, `Description`) VALUES (3, 'Freezing drizzle');
INSERT INTO `Delivery_System`.`Precipitation` (`Precipitation_ID`, `Description`) VALUES (4, 'Freezing rain');
INSERT INTO `Delivery_System`.`Precipitation` (`Precipitation_ID`, `Description`) VALUES (5, 'Rain  and snow mixed');
INSERT INTO `Delivery_System`.`Precipitation` (`Precipitation_ID`, `Description`) VALUES (6, 'Snow');
INSERT INTO `Delivery_System`.`Precipitation` (`Precipitation_ID`, `Description`) VALUES (7, 'Snow grains');
INSERT INTO `Delivery_System`.`Precipitation` (`Precipitation_ID`, `Description`) VALUES (8, 'Ice pellets/Sleet');
INSERT INTO `Delivery_System`.`Precipitation` (`Precipitation_ID`, `Description`) VALUES (9, 'Hail');
INSERT INTO `Delivery_System`.`Precipitation` (`Precipitation_ID`, `Description`) VALUES (10, 'Snow pellets/ Graupel');
INSERT INTO `Delivery_System`.`Precipitation` (`Precipitation_ID`, `Description`) VALUES (11, 'Ice Crystals');

COMMIT;


-- -----------------------------------------------------
-- Data for table `Delivery_System`.`Direction`
-- -----------------------------------------------------
START TRANSACTION;
USE `Delivery_System`;
INSERT INTO `Delivery_System`.`Direction` (`Direction_ID`, `Description`) VALUES (1, 'North');
INSERT INTO `Delivery_System`.`Direction` (`Direction_ID`, `Description`) VALUES (2, 'South');
INSERT INTO `Delivery_System`.`Direction` (`Direction_ID`, `Description`) VALUES (3, 'East');
INSERT INTO `Delivery_System`.`Direction` (`Direction_ID`, `Description`) VALUES (4, 'West');
INSERT INTO `Delivery_System`.`Direction` (`Direction_ID`, `Description`) VALUES (5, 'North-East');
INSERT INTO `Delivery_System`.`Direction` (`Direction_ID`, `Description`) VALUES (6, 'North-West');
INSERT INTO `Delivery_System`.`Direction` (`Direction_ID`, `Description`) VALUES (7, 'South-East');
INSERT INTO `Delivery_System`.`Direction` (`Direction_ID`, `Description`) VALUES (8, 'South-West');

COMMIT;


-- -----------------------------------------------------
-- Data for table `Delivery_System`.`Weather`
-- -----------------------------------------------------
START TRANSACTION;
USE `Delivery_System`;
INSERT INTO `Delivery_System`.`Weather` (`Weather_ID`, `Temperature`, `Humidity`, `Wind_Speed`, `Precipitation_ID`, `Direction_ID`, `Zip_Code`) VALUES ('2012-06-25 20:23:56', -112, '1', 231, 1, 1, 12111);
INSERT INTO `Delivery_System`.`Weather` (`Weather_ID`, `Temperature`, `Humidity`, `Wind_Speed`, `Precipitation_ID`, `Direction_ID`, `Zip_Code`) VALUES ('2012-07-06 14:26:44', -19, '17', 230, 4, 8, 12131);
INSERT INTO `Delivery_System`.`Weather` (`Weather_ID`, `Temperature`, `Humidity`, `Wind_Speed`, `Precipitation_ID`, `Direction_ID`, `Zip_Code`) VALUES ('2012-07-09 20:42:52', 39, '36', 121, 4, 6, 12120);
INSERT INTO `Delivery_System`.`Weather` (`Weather_ID`, `Temperature`, `Humidity`, `Wind_Speed`, `Precipitation_ID`, `Direction_ID`, `Zip_Code`) VALUES ('2012-07-14 00:33:29', 95, '95', 49, 4, 5, 12189);
INSERT INTO `Delivery_System`.`Weather` (`Weather_ID`, `Temperature`, `Humidity`, `Wind_Speed`, `Precipitation_ID`, `Direction_ID`, `Zip_Code`) VALUES ('2012-07-20 10:50:08', 114, '12', 31, 8, 7, 12192);
INSERT INTO `Delivery_System`.`Weather` (`Weather_ID`, `Temperature`, `Humidity`, `Wind_Speed`, `Precipitation_ID`, `Direction_ID`, `Zip_Code`) VALUES ('2012-08-09 20:57:03', -24, '33', 183, 6, 8, 17854);
INSERT INTO `Delivery_System`.`Weather` (`Weather_ID`, `Temperature`, `Humidity`, `Wind_Speed`, `Precipitation_ID`, `Direction_ID`, `Zip_Code`) VALUES ('2012-08-29 12:35:33', -6, '99', 30, 1, 3, 17845);
INSERT INTO `Delivery_System`.`Weather` (`Weather_ID`, `Temperature`, `Humidity`, `Wind_Speed`, `Precipitation_ID`, `Direction_ID`, `Zip_Code`) VALUES ('2012-09-02 15:32:35', -1, '34', 87, 5, 5, 17842);
INSERT INTO `Delivery_System`.`Weather` (`Weather_ID`, `Temperature`, `Humidity`, `Wind_Speed`, `Precipitation_ID`, `Direction_ID`, `Zip_Code`) VALUES ('2012-09-12 08:04:45', -71, '52', 228, 8, 6, 17830);
INSERT INTO `Delivery_System`.`Weather` (`Weather_ID`, `Temperature`, `Humidity`, `Wind_Speed`, `Precipitation_ID`, `Direction_ID`, `Zip_Code`) VALUES ('2012-09-19 12:34:39', -26, '63', 68, 4, 3, 17845);
INSERT INTO `Delivery_System`.`Weather` (`Weather_ID`, `Temperature`, `Humidity`, `Wind_Speed`, `Precipitation_ID`, `Direction_ID`, `Zip_Code`) VALUES ('2012-10-18 08:27:15', -40, '40', 89, 4, 4, 25681);
INSERT INTO `Delivery_System`.`Weather` (`Weather_ID`, `Temperature`, `Humidity`, `Wind_Speed`, `Precipitation_ID`, `Direction_ID`, `Zip_Code`) VALUES ('2012-10-21 09:23:29', 45, '14', 65, 9, 2, 25654);
INSERT INTO `Delivery_System`.`Weather` (`Weather_ID`, `Temperature`, `Humidity`, `Wind_Speed`, `Precipitation_ID`, `Direction_ID`, `Zip_Code`) VALUES ('2012-11-06 05:52:00', -10, '100', 30, 10, 8, 25664);
INSERT INTO `Delivery_System`.`Weather` (`Weather_ID`, `Temperature`, `Humidity`, `Wind_Speed`, `Precipitation_ID`, `Direction_ID`, `Zip_Code`) VALUES ('2012-12-02 10:31:17', 35, '23', 70, 7, 4, 25648);
INSERT INTO `Delivery_System`.`Weather` (`Weather_ID`, `Temperature`, `Humidity`, `Wind_Speed`, `Precipitation_ID`, `Direction_ID`, `Zip_Code`) VALUES ('2012-12-03 06:55:05', 130, '98', 92, 9, 4, 25623);
INSERT INTO `Delivery_System`.`Weather` (`Weather_ID`, `Temperature`, `Humidity`, `Wind_Speed`, `Precipitation_ID`, `Direction_ID`, `Zip_Code`) VALUES ('2012-12-05 05:19:31', 87, '100', 173, 10, 4, 31822);
INSERT INTO `Delivery_System`.`Weather` (`Weather_ID`, `Temperature`, `Humidity`, `Wind_Speed`, `Precipitation_ID`, `Direction_ID`, `Zip_Code`) VALUES ('2012-12-15 04:01:45', 13, '93', 53, 3, 2, 31874);
INSERT INTO `Delivery_System`.`Weather` (`Weather_ID`, `Temperature`, `Humidity`, `Wind_Speed`, `Precipitation_ID`, `Direction_ID`, `Zip_Code`) VALUES ('2012-12-29 00:46:36', -37, '80', 47, 6, 1, 31849);
INSERT INTO `Delivery_System`.`Weather` (`Weather_ID`, `Temperature`, `Humidity`, `Wind_Speed`, `Precipitation_ID`, `Direction_ID`, `Zip_Code`) VALUES ('2013-01-12 07:58:10', -57, '66', 225, 11, 4, 31834);
INSERT INTO `Delivery_System`.`Weather` (`Weather_ID`, `Temperature`, `Humidity`, `Wind_Speed`, `Precipitation_ID`, `Direction_ID`, `Zip_Code`) VALUES ('2013-02-04 06:15:19', 98, '81', 133, 7, 8, 31841);
INSERT INTO `Delivery_System`.`Weather` (`Weather_ID`, `Temperature`, `Humidity`, `Wind_Speed`, `Precipitation_ID`, `Direction_ID`, `Zip_Code`) VALUES ('2013-02-10 18:25:53', 96, '95', 211, 4, 2, 48344);
INSERT INTO `Delivery_System`.`Weather` (`Weather_ID`, `Temperature`, `Humidity`, `Wind_Speed`, `Precipitation_ID`, `Direction_ID`, `Zip_Code`) VALUES ('2013-02-15 14:14:50', 43, '7', 170, 5, 3, 48314);
INSERT INTO `Delivery_System`.`Weather` (`Weather_ID`, `Temperature`, `Humidity`, `Wind_Speed`, `Precipitation_ID`, `Direction_ID`, `Zip_Code`) VALUES ('2013-02-26 09:07:59', 43, '10', 49, 7, 2, 48356);
INSERT INTO `Delivery_System`.`Weather` (`Weather_ID`, `Temperature`, `Humidity`, `Wind_Speed`, `Precipitation_ID`, `Direction_ID`, `Zip_Code`) VALUES ('2013-03-17 19:34:14', 0, '90', 85, 7, 4, 48350);
INSERT INTO `Delivery_System`.`Weather` (`Weather_ID`, `Temperature`, `Humidity`, `Wind_Speed`, `Precipitation_ID`, `Direction_ID`, `Zip_Code`) VALUES ('2013-03-24 15:29:05', 51, '10', 231, 9, 6, 48363);
INSERT INTO `Delivery_System`.`Weather` (`Weather_ID`, `Temperature`, `Humidity`, `Wind_Speed`, `Precipitation_ID`, `Direction_ID`, `Zip_Code`) VALUES ('2013-03-26 23:09:43', 78, '74', 112, 8, 4, 53764);
INSERT INTO `Delivery_System`.`Weather` (`Weather_ID`, `Temperature`, `Humidity`, `Wind_Speed`, `Precipitation_ID`, `Direction_ID`, `Zip_Code`) VALUES ('2013-03-31 06:51:46', -21, '40', 166, 11, 8, 53790);
INSERT INTO `Delivery_System`.`Weather` (`Weather_ID`, `Temperature`, `Humidity`, `Wind_Speed`, `Precipitation_ID`, `Direction_ID`, `Zip_Code`) VALUES ('2013-04-12 00:00:41', 131, '99', 121, 8, 8, 53735);
INSERT INTO `Delivery_System`.`Weather` (`Weather_ID`, `Temperature`, `Humidity`, `Wind_Speed`, `Precipitation_ID`, `Direction_ID`, `Zip_Code`) VALUES ('2013-04-28 08:46:29', 111, '49', 172, 4, 5, 53740);
INSERT INTO `Delivery_System`.`Weather` (`Weather_ID`, `Temperature`, `Humidity`, `Wind_Speed`, `Precipitation_ID`, `Direction_ID`, `Zip_Code`) VALUES ('2013-05-09 06:28:05', 110, '90', 152, 4, 7, 53742);
INSERT INTO `Delivery_System`.`Weather` (`Weather_ID`, `Temperature`, `Humidity`, `Wind_Speed`, `Precipitation_ID`, `Direction_ID`, `Zip_Code`) VALUES ('2013-05-11 19:39:50', 101, '34', 71, 8, 3, 12391);
INSERT INTO `Delivery_System`.`Weather` (`Weather_ID`, `Temperature`, `Humidity`, `Wind_Speed`, `Precipitation_ID`, `Direction_ID`, `Zip_Code`) VALUES ('2013-05-20 11:06:28', 58, '39', 135, 4, 4, 12325);
INSERT INTO `Delivery_System`.`Weather` (`Weather_ID`, `Temperature`, `Humidity`, `Wind_Speed`, `Precipitation_ID`, `Direction_ID`, `Zip_Code`) VALUES ('2013-06-12 12:56:20', 92, '73', 39, 8, 7, 12364);
INSERT INTO `Delivery_System`.`Weather` (`Weather_ID`, `Temperature`, `Humidity`, `Wind_Speed`, `Precipitation_ID`, `Direction_ID`, `Zip_Code`) VALUES ('2013-06-14 03:37:49', 69, '31', 152, 10, 6, 12393);
INSERT INTO `Delivery_System`.`Weather` (`Weather_ID`, `Temperature`, `Humidity`, `Wind_Speed`, `Precipitation_ID`, `Direction_ID`, `Zip_Code`) VALUES ('2013-06-18 09:56:16', 106, '74', 172, 4, 6, 12389);
INSERT INTO `Delivery_System`.`Weather` (`Weather_ID`, `Temperature`, `Humidity`, `Wind_Speed`, `Precipitation_ID`, `Direction_ID`, `Zip_Code`) VALUES ('2013-06-19 19:32:39', -14, '40', 87, 6, 7, 20836);
INSERT INTO `Delivery_System`.`Weather` (`Weather_ID`, `Temperature`, `Humidity`, `Wind_Speed`, `Precipitation_ID`, `Direction_ID`, `Zip_Code`) VALUES ('2013-06-21 18:15:13', -29, '95', 23, 4, 3, 20898);
INSERT INTO `Delivery_System`.`Weather` (`Weather_ID`, `Temperature`, `Humidity`, `Wind_Speed`, `Precipitation_ID`, `Direction_ID`, `Zip_Code`) VALUES ('2013-06-22 09:57:34', -43, '6', 109, 7, 2, 20875);
INSERT INTO `Delivery_System`.`Weather` (`Weather_ID`, `Temperature`, `Humidity`, `Wind_Speed`, `Precipitation_ID`, `Direction_ID`, `Zip_Code`) VALUES ('2013-07-08 00:42:52', -74, '75', 84, 7, 8, 20862);
INSERT INTO `Delivery_System`.`Weather` (`Weather_ID`, `Temperature`, `Humidity`, `Wind_Speed`, `Precipitation_ID`, `Direction_ID`, `Zip_Code`) VALUES ('2013-07-20 04:46:00', 69, '34', 51, 7, 7, 20885);
INSERT INTO `Delivery_System`.`Weather` (`Weather_ID`, `Temperature`, `Humidity`, `Wind_Speed`, `Precipitation_ID`, `Direction_ID`, `Zip_Code`) VALUES ('2013-08-03 16:06:44', 35, '76', 77, 3, 6, 45491);
INSERT INTO `Delivery_System`.`Weather` (`Weather_ID`, `Temperature`, `Humidity`, `Wind_Speed`, `Precipitation_ID`, `Direction_ID`, `Zip_Code`) VALUES ('2013-08-22 02:31:47', -79, '100', 60, 4, 6, 45425);
INSERT INTO `Delivery_System`.`Weather` (`Weather_ID`, `Temperature`, `Humidity`, `Wind_Speed`, `Precipitation_ID`, `Direction_ID`, `Zip_Code`) VALUES ('2013-09-01 18:15:40', -3, '68', 102, 1, 5, 45430);
INSERT INTO `Delivery_System`.`Weather` (`Weather_ID`, `Temperature`, `Humidity`, `Wind_Speed`, `Precipitation_ID`, `Direction_ID`, `Zip_Code`) VALUES ('2013-10-11 23:25:37', 121, '73', 97, 3, 1, 45429);
INSERT INTO `Delivery_System`.`Weather` (`Weather_ID`, `Temperature`, `Humidity`, `Wind_Speed`, `Precipitation_ID`, `Direction_ID`, `Zip_Code`) VALUES ('2013-11-10 18:11:31', 98, '69', 144, 4, 5, 45493);
INSERT INTO `Delivery_System`.`Weather` (`Weather_ID`, `Temperature`, `Humidity`, `Wind_Speed`, `Precipitation_ID`, `Direction_ID`, `Zip_Code`) VALUES ('2013-11-29 01:10:57', -98, '26', 96, 6, 2, 28733);
INSERT INTO `Delivery_System`.`Weather` (`Weather_ID`, `Temperature`, `Humidity`, `Wind_Speed`, `Precipitation_ID`, `Direction_ID`, `Zip_Code`) VALUES ('2013-12-08 01:18:54', 49, '12', 141, 4, 6, 28733);
INSERT INTO `Delivery_System`.`Weather` (`Weather_ID`, `Temperature`, `Humidity`, `Wind_Speed`, `Precipitation_ID`, `Direction_ID`, `Zip_Code`) VALUES ('2013-12-21 23:39:31', 95, '81', 109, 3, 4, 28762);
INSERT INTO `Delivery_System`.`Weather` (`Weather_ID`, `Temperature`, `Humidity`, `Wind_Speed`, `Precipitation_ID`, `Direction_ID`, `Zip_Code`) VALUES ('2014-01-11 18:07:47', -86, '55', 171, 3, 1, 28763);
INSERT INTO `Delivery_System`.`Weather` (`Weather_ID`, `Temperature`, `Humidity`, `Wind_Speed`, `Precipitation_ID`, `Direction_ID`, `Zip_Code`) VALUES ('2014-01-27 17:13:04', -102, '16', 107, 11, 6, 28768);
INSERT INTO `Delivery_System`.`Weather` (`Weather_ID`, `Temperature`, `Humidity`, `Wind_Speed`, `Precipitation_ID`, `Direction_ID`, `Zip_Code`) VALUES ('2014-02-04 08:44:00', -63, '15', 104, 3, 1, 76588);
INSERT INTO `Delivery_System`.`Weather` (`Weather_ID`, `Temperature`, `Humidity`, `Wind_Speed`, `Precipitation_ID`, `Direction_ID`, `Zip_Code`) VALUES ('2014-02-19 13:16:08', -21, '20', 139, 7, 5, 76517);
INSERT INTO `Delivery_System`.`Weather` (`Weather_ID`, `Temperature`, `Humidity`, `Wind_Speed`, `Precipitation_ID`, `Direction_ID`, `Zip_Code`) VALUES ('2014-02-19 21:11:45', 17, '98', 171, 6, 1, 76537);
INSERT INTO `Delivery_System`.`Weather` (`Weather_ID`, `Temperature`, `Humidity`, `Wind_Speed`, `Precipitation_ID`, `Direction_ID`, `Zip_Code`) VALUES ('2014-02-21 20:12:57', -89, '34', 123, 10, 4, 76546);
INSERT INTO `Delivery_System`.`Weather` (`Weather_ID`, `Temperature`, `Humidity`, `Wind_Speed`, `Precipitation_ID`, `Direction_ID`, `Zip_Code`) VALUES ('2014-02-23 06:49:09', -106, '22', 66, 10, 6, 76584);
INSERT INTO `Delivery_System`.`Weather` (`Weather_ID`, `Temperature`, `Humidity`, `Wind_Speed`, `Precipitation_ID`, `Direction_ID`, `Zip_Code`) VALUES ('2014-02-25 18:20:24', -94, '56', 68, 4, 2, 67823);
INSERT INTO `Delivery_System`.`Weather` (`Weather_ID`, `Temperature`, `Humidity`, `Wind_Speed`, `Precipitation_ID`, `Direction_ID`, `Zip_Code`) VALUES ('2014-02-26 13:46:44', 86, '54', 146, 1, 8, 67866);
INSERT INTO `Delivery_System`.`Weather` (`Weather_ID`, `Temperature`, `Humidity`, `Wind_Speed`, `Precipitation_ID`, `Direction_ID`, `Zip_Code`) VALUES ('2014-03-05 08:21:08', 17, '2', 187, 4, 7, 67835);
INSERT INTO `Delivery_System`.`Weather` (`Weather_ID`, `Temperature`, `Humidity`, `Wind_Speed`, `Precipitation_ID`, `Direction_ID`, `Zip_Code`) VALUES ('2014-03-17 13:30:36', 63, '60', 86, 10, 7, 67881);
INSERT INTO `Delivery_System`.`Weather` (`Weather_ID`, `Temperature`, `Humidity`, `Wind_Speed`, `Precipitation_ID`, `Direction_ID`, `Zip_Code`) VALUES ('2014-03-26 08:43:34', -22, '24', 148, 2, 6, 67845);
INSERT INTO `Delivery_System`.`Weather` (`Weather_ID`, `Temperature`, `Humidity`, `Wind_Speed`, `Precipitation_ID`, `Direction_ID`, `Zip_Code`) VALUES ('2014-04-15 02:18:08', -112, '64', 53, 11, 8, 54324);
INSERT INTO `Delivery_System`.`Weather` (`Weather_ID`, `Temperature`, `Humidity`, `Wind_Speed`, `Precipitation_ID`, `Direction_ID`, `Zip_Code`) VALUES ('2014-04-17 00:54:42', 121, '57', 173, 7, 7, 54334);
INSERT INTO `Delivery_System`.`Weather` (`Weather_ID`, `Temperature`, `Humidity`, `Wind_Speed`, `Precipitation_ID`, `Direction_ID`, `Zip_Code`) VALUES ('2014-04-17 03:03:49', 13, '45', 204, 6, 3, 54363);
INSERT INTO `Delivery_System`.`Weather` (`Weather_ID`, `Temperature`, `Humidity`, `Wind_Speed`, `Precipitation_ID`, `Direction_ID`, `Zip_Code`) VALUES ('2014-04-20 14:38:42', -109, '23', 31, 2, 1, 54330);
INSERT INTO `Delivery_System`.`Weather` (`Weather_ID`, `Temperature`, `Humidity`, `Wind_Speed`, `Precipitation_ID`, `Direction_ID`, `Zip_Code`) VALUES ('2014-05-07 15:19:23', -48, '71', 20, 9, 2, 54360);
INSERT INTO `Delivery_System`.`Weather` (`Weather_ID`, `Temperature`, `Humidity`, `Wind_Speed`, `Precipitation_ID`, `Direction_ID`, `Zip_Code`) VALUES ('2014-05-08 11:50:16', -13, '35', 126, 7, 3, 61672);
INSERT INTO `Delivery_System`.`Weather` (`Weather_ID`, `Temperature`, `Humidity`, `Wind_Speed`, `Precipitation_ID`, `Direction_ID`, `Zip_Code`) VALUES ('2014-05-29 04:21:32', 122, '31', 186, 9, 2, 61694);
INSERT INTO `Delivery_System`.`Weather` (`Weather_ID`, `Temperature`, `Humidity`, `Wind_Speed`, `Precipitation_ID`, `Direction_ID`, `Zip_Code`) VALUES ('2014-06-19 07:56:18', -54, '76', 83, 3, 7, 61699);
INSERT INTO `Delivery_System`.`Weather` (`Weather_ID`, `Temperature`, `Humidity`, `Wind_Speed`, `Precipitation_ID`, `Direction_ID`, `Zip_Code`) VALUES ('2014-06-25 20:16:41', -51, '89', 90, 2, 3, 61637);
INSERT INTO `Delivery_System`.`Weather` (`Weather_ID`, `Temperature`, `Humidity`, `Wind_Speed`, `Precipitation_ID`, `Direction_ID`, `Zip_Code`) VALUES ('2014-07-03 06:49:20', 40, '17', 111, 5, 4, 61699);
INSERT INTO `Delivery_System`.`Weather` (`Weather_ID`, `Temperature`, `Humidity`, `Wind_Speed`, `Precipitation_ID`, `Direction_ID`, `Zip_Code`) VALUES ('2014-07-07 13:36:48', 8, '45', 20, 1, 1, 67881);
INSERT INTO `Delivery_System`.`Weather` (`Weather_ID`, `Temperature`, `Humidity`, `Wind_Speed`, `Precipitation_ID`, `Direction_ID`, `Zip_Code`) VALUES ('2014-07-20 04:17:31', -102, '6', 88, 5, 6, 67823);
INSERT INTO `Delivery_System`.`Weather` (`Weather_ID`, `Temperature`, `Humidity`, `Wind_Speed`, `Precipitation_ID`, `Direction_ID`, `Zip_Code`) VALUES ('2014-07-22 09:44:19', -9, '26', 53, 9, 4, 67866);
INSERT INTO `Delivery_System`.`Weather` (`Weather_ID`, `Temperature`, `Humidity`, `Wind_Speed`, `Precipitation_ID`, `Direction_ID`, `Zip_Code`) VALUES ('2014-08-03 04:39:59', -67, '83', 70, 6, 6, 67835);
INSERT INTO `Delivery_System`.`Weather` (`Weather_ID`, `Temperature`, `Humidity`, `Wind_Speed`, `Precipitation_ID`, `Direction_ID`, `Zip_Code`) VALUES ('2014-08-14 11:27:42', 41, '83', 229, 10, 7, 67881);
INSERT INTO `Delivery_System`.`Weather` (`Weather_ID`, `Temperature`, `Humidity`, `Wind_Speed`, `Precipitation_ID`, `Direction_ID`, `Zip_Code`) VALUES ('2014-08-24 10:31:52', 50, '27', 112, 1, 3, 67845);
INSERT INTO `Delivery_System`.`Weather` (`Weather_ID`, `Temperature`, `Humidity`, `Wind_Speed`, `Precipitation_ID`, `Direction_ID`, `Zip_Code`) VALUES ('2014-08-25 07:24:55', 75, '32', 161, 4, 5, 54324);
INSERT INTO `Delivery_System`.`Weather` (`Weather_ID`, `Temperature`, `Humidity`, `Wind_Speed`, `Precipitation_ID`, `Direction_ID`, `Zip_Code`) VALUES ('2014-09-08 10:08:29', 57, '30', 149, 1, 7, 54334);
INSERT INTO `Delivery_System`.`Weather` (`Weather_ID`, `Temperature`, `Humidity`, `Wind_Speed`, `Precipitation_ID`, `Direction_ID`, `Zip_Code`) VALUES ('2014-09-24 14:18:35', 9, '34', 152, 5, 2, 54363);
INSERT INTO `Delivery_System`.`Weather` (`Weather_ID`, `Temperature`, `Humidity`, `Wind_Speed`, `Precipitation_ID`, `Direction_ID`, `Zip_Code`) VALUES ('2014-10-11 16:26:39', -93, '71', 156, 7, 7, 54330);
INSERT INTO `Delivery_System`.`Weather` (`Weather_ID`, `Temperature`, `Humidity`, `Wind_Speed`, `Precipitation_ID`, `Direction_ID`, `Zip_Code`) VALUES ('2014-10-16 18:42:56', -5, '40', 75, 9, 2, 61699);
INSERT INTO `Delivery_System`.`Weather` (`Weather_ID`, `Temperature`, `Humidity`, `Wind_Speed`, `Precipitation_ID`, `Direction_ID`, `Zip_Code`) VALUES ('2014-10-25 22:46:39', 8, '83', 214, 1, 7, 67845);
INSERT INTO `Delivery_System`.`Weather` (`Weather_ID`, `Temperature`, `Humidity`, `Wind_Speed`, `Precipitation_ID`, `Direction_ID`, `Zip_Code`) VALUES ('2014-10-26 10:37:38', -25, '58', 48, 8, 1, 54324);
INSERT INTO `Delivery_System`.`Weather` (`Weather_ID`, `Temperature`, `Humidity`, `Wind_Speed`, `Precipitation_ID`, `Direction_ID`, `Zip_Code`) VALUES ('2014-11-08 18:36:28', 9, '96', 48, 9, 4, 54334);
INSERT INTO `Delivery_System`.`Weather` (`Weather_ID`, `Temperature`, `Humidity`, `Wind_Speed`, `Precipitation_ID`, `Direction_ID`, `Zip_Code`) VALUES ('2014-11-18 09:45:45', 15, '100', 113, 4, 4, 54363);
INSERT INTO `Delivery_System`.`Weather` (`Weather_ID`, `Temperature`, `Humidity`, `Wind_Speed`, `Precipitation_ID`, `Direction_ID`, `Zip_Code`) VALUES ('2014-11-23 13:45:05', 70, '50', 88, 5, 2, 54330);
INSERT INTO `Delivery_System`.`Weather` (`Weather_ID`, `Temperature`, `Humidity`, `Wind_Speed`, `Precipitation_ID`, `Direction_ID`, `Zip_Code`) VALUES ('2014-12-03 14:33:18', 55, '66', 164, 1, 7, 54360);
INSERT INTO `Delivery_System`.`Weather` (`Weather_ID`, `Temperature`, `Humidity`, `Wind_Speed`, `Precipitation_ID`, `Direction_ID`, `Zip_Code`) VALUES ('2014-12-07 20:58:39', 134, '89', 198, 1, 2, 61672);
INSERT INTO `Delivery_System`.`Weather` (`Weather_ID`, `Temperature`, `Humidity`, `Wind_Speed`, `Precipitation_ID`, `Direction_ID`, `Zip_Code`) VALUES ('2014-12-10 13:28:02', -5, '40', 200, 9, 6, 61694);
INSERT INTO `Delivery_System`.`Weather` (`Weather_ID`, `Temperature`, `Humidity`, `Wind_Speed`, `Precipitation_ID`, `Direction_ID`, `Zip_Code`) VALUES ('2014-12-13 23:39:36', -32, '33', 116, 5, 3, 12189);
INSERT INTO `Delivery_System`.`Weather` (`Weather_ID`, `Temperature`, `Humidity`, `Wind_Speed`, `Precipitation_ID`, `Direction_ID`, `Zip_Code`) VALUES ('2014-12-31 00:10:23', 12, '65', 168, 4, 3, 12192);
INSERT INTO `Delivery_System`.`Weather` (`Weather_ID`, `Temperature`, `Humidity`, `Wind_Speed`, `Precipitation_ID`, `Direction_ID`, `Zip_Code`) VALUES ('2015-01-01 00:33:15', -28, '3', 77, 5, 8, 17854);
INSERT INTO `Delivery_System`.`Weather` (`Weather_ID`, `Temperature`, `Humidity`, `Wind_Speed`, `Precipitation_ID`, `Direction_ID`, `Zip_Code`) VALUES ('2015-01-19 10:41:59', 11, '8', 157, 1, 4, 17845);
INSERT INTO `Delivery_System`.`Weather` (`Weather_ID`, `Temperature`, `Humidity`, `Wind_Speed`, `Precipitation_ID`, `Direction_ID`, `Zip_Code`) VALUES ('2015-01-29 20:51:22', -47, '15', 53, 2, 3, 17842);
INSERT INTO `Delivery_System`.`Weather` (`Weather_ID`, `Temperature`, `Humidity`, `Wind_Speed`, `Precipitation_ID`, `Direction_ID`, `Zip_Code`) VALUES ('2015-02-05 01:30:51', 129, '22', 229, 1, 3, 48314);
INSERT INTO `Delivery_System`.`Weather` (`Weather_ID`, `Temperature`, `Humidity`, `Wind_Speed`, `Precipitation_ID`, `Direction_ID`, `Zip_Code`) VALUES ('2015-02-10 21:27:54', -87, '28', 42, 5, 6, 48356);
INSERT INTO `Delivery_System`.`Weather` (`Weather_ID`, `Temperature`, `Humidity`, `Wind_Speed`, `Precipitation_ID`, `Direction_ID`, `Zip_Code`) VALUES ('2015-02-12 23:14:08', -8, '83', 190, 9, 3, 48350);
INSERT INTO `Delivery_System`.`Weather` (`Weather_ID`, `Temperature`, `Humidity`, `Wind_Speed`, `Precipitation_ID`, `Direction_ID`, `Zip_Code`) VALUES ('2015-03-20 13:39:29', -103, '99', 134, 10, 2, 48363);
INSERT INTO `Delivery_System`.`Weather` (`Weather_ID`, `Temperature`, `Humidity`, `Wind_Speed`, `Precipitation_ID`, `Direction_ID`, `Zip_Code`) VALUES ('2015-04-04 20:29:52', 136, '100', 20, 11, 8, 53764);

COMMIT;


-- -----------------------------------------------------
-- Data for table `Delivery_System`.`Payment_Method`
-- -----------------------------------------------------
START TRANSACTION;
USE `Delivery_System`;
INSERT INTO `Delivery_System`.`Payment_Method` (`Method_ID`, `Type`) VALUES (1, 'C');
INSERT INTO `Delivery_System`.`Payment_Method` (`Method_ID`, `Type`) VALUES (2, 'G');
INSERT INTO `Delivery_System`.`Payment_Method` (`Method_ID`, `Type`) VALUES (3, 'O');
INSERT INTO `Delivery_System`.`Payment_Method` (`Method_ID`, `Type`) VALUES (4, 'C');
INSERT INTO `Delivery_System`.`Payment_Method` (`Method_ID`, `Type`) VALUES (5, 'O');
INSERT INTO `Delivery_System`.`Payment_Method` (`Method_ID`, `Type`) VALUES (6, 'O');
INSERT INTO `Delivery_System`.`Payment_Method` (`Method_ID`, `Type`) VALUES (7, 'G');
INSERT INTO `Delivery_System`.`Payment_Method` (`Method_ID`, `Type`) VALUES (8, 'O');
INSERT INTO `Delivery_System`.`Payment_Method` (`Method_ID`, `Type`) VALUES (9, 'C');
INSERT INTO `Delivery_System`.`Payment_Method` (`Method_ID`, `Type`) VALUES (10, 'G');
INSERT INTO `Delivery_System`.`Payment_Method` (`Method_ID`, `Type`) VALUES (11, 'O');
INSERT INTO `Delivery_System`.`Payment_Method` (`Method_ID`, `Type`) VALUES (12, 'C');
INSERT INTO `Delivery_System`.`Payment_Method` (`Method_ID`, `Type`) VALUES (13, 'O');
INSERT INTO `Delivery_System`.`Payment_Method` (`Method_ID`, `Type`) VALUES (14, 'G');
INSERT INTO `Delivery_System`.`Payment_Method` (`Method_ID`, `Type`) VALUES (15, 'C');
INSERT INTO `Delivery_System`.`Payment_Method` (`Method_ID`, `Type`) VALUES (16, 'O');
INSERT INTO `Delivery_System`.`Payment_Method` (`Method_ID`, `Type`) VALUES (17, 'O');
INSERT INTO `Delivery_System`.`Payment_Method` (`Method_ID`, `Type`) VALUES (18, 'G');
INSERT INTO `Delivery_System`.`Payment_Method` (`Method_ID`, `Type`) VALUES (19, 'O');
INSERT INTO `Delivery_System`.`Payment_Method` (`Method_ID`, `Type`) VALUES (20, 'O');
INSERT INTO `Delivery_System`.`Payment_Method` (`Method_ID`, `Type`) VALUES (21, 'G');
INSERT INTO `Delivery_System`.`Payment_Method` (`Method_ID`, `Type`) VALUES (22, 'O');
INSERT INTO `Delivery_System`.`Payment_Method` (`Method_ID`, `Type`) VALUES (23, 'O');
INSERT INTO `Delivery_System`.`Payment_Method` (`Method_ID`, `Type`) VALUES (24, 'O');
INSERT INTO `Delivery_System`.`Payment_Method` (`Method_ID`, `Type`) VALUES (25, 'G');
INSERT INTO `Delivery_System`.`Payment_Method` (`Method_ID`, `Type`) VALUES (26, 'G');
INSERT INTO `Delivery_System`.`Payment_Method` (`Method_ID`, `Type`) VALUES (27, 'G');
INSERT INTO `Delivery_System`.`Payment_Method` (`Method_ID`, `Type`) VALUES (28, 'C');
INSERT INTO `Delivery_System`.`Payment_Method` (`Method_ID`, `Type`) VALUES (29, 'O');
INSERT INTO `Delivery_System`.`Payment_Method` (`Method_ID`, `Type`) VALUES (30, 'O');
INSERT INTO `Delivery_System`.`Payment_Method` (`Method_ID`, `Type`) VALUES (31, 'G');
INSERT INTO `Delivery_System`.`Payment_Method` (`Method_ID`, `Type`) VALUES (32, 'G');
INSERT INTO `Delivery_System`.`Payment_Method` (`Method_ID`, `Type`) VALUES (33, 'O');
INSERT INTO `Delivery_System`.`Payment_Method` (`Method_ID`, `Type`) VALUES (34, 'C');
INSERT INTO `Delivery_System`.`Payment_Method` (`Method_ID`, `Type`) VALUES (35, 'O');
INSERT INTO `Delivery_System`.`Payment_Method` (`Method_ID`, `Type`) VALUES (36, 'C');
INSERT INTO `Delivery_System`.`Payment_Method` (`Method_ID`, `Type`) VALUES (37, 'O');
INSERT INTO `Delivery_System`.`Payment_Method` (`Method_ID`, `Type`) VALUES (38, 'G');
INSERT INTO `Delivery_System`.`Payment_Method` (`Method_ID`, `Type`) VALUES (39, 'C');
INSERT INTO `Delivery_System`.`Payment_Method` (`Method_ID`, `Type`) VALUES (40, 'O');
INSERT INTO `Delivery_System`.`Payment_Method` (`Method_ID`, `Type`) VALUES (41, 'O');
INSERT INTO `Delivery_System`.`Payment_Method` (`Method_ID`, `Type`) VALUES (42, 'O');
INSERT INTO `Delivery_System`.`Payment_Method` (`Method_ID`, `Type`) VALUES (43, 'O');
INSERT INTO `Delivery_System`.`Payment_Method` (`Method_ID`, `Type`) VALUES (44, 'G');
INSERT INTO `Delivery_System`.`Payment_Method` (`Method_ID`, `Type`) VALUES (45, 'G');
INSERT INTO `Delivery_System`.`Payment_Method` (`Method_ID`, `Type`) VALUES (46, 'C');
INSERT INTO `Delivery_System`.`Payment_Method` (`Method_ID`, `Type`) VALUES (47, 'O');
INSERT INTO `Delivery_System`.`Payment_Method` (`Method_ID`, `Type`) VALUES (48, 'C');
INSERT INTO `Delivery_System`.`Payment_Method` (`Method_ID`, `Type`) VALUES (49, 'C');
INSERT INTO `Delivery_System`.`Payment_Method` (`Method_ID`, `Type`) VALUES (50, 'C');
INSERT INTO `Delivery_System`.`Payment_Method` (`Method_ID`, `Type`) VALUES (51, 'G');
INSERT INTO `Delivery_System`.`Payment_Method` (`Method_ID`, `Type`) VALUES (52, 'O');
INSERT INTO `Delivery_System`.`Payment_Method` (`Method_ID`, `Type`) VALUES (53, 'O');
INSERT INTO `Delivery_System`.`Payment_Method` (`Method_ID`, `Type`) VALUES (54, 'O');
INSERT INTO `Delivery_System`.`Payment_Method` (`Method_ID`, `Type`) VALUES (55, 'O');
INSERT INTO `Delivery_System`.`Payment_Method` (`Method_ID`, `Type`) VALUES (56, 'G');
INSERT INTO `Delivery_System`.`Payment_Method` (`Method_ID`, `Type`) VALUES (57, 'G');
INSERT INTO `Delivery_System`.`Payment_Method` (`Method_ID`, `Type`) VALUES (58, 'O');
INSERT INTO `Delivery_System`.`Payment_Method` (`Method_ID`, `Type`) VALUES (59, 'C');
INSERT INTO `Delivery_System`.`Payment_Method` (`Method_ID`, `Type`) VALUES (60, 'O');
INSERT INTO `Delivery_System`.`Payment_Method` (`Method_ID`, `Type`) VALUES (61, 'C');
INSERT INTO `Delivery_System`.`Payment_Method` (`Method_ID`, `Type`) VALUES (62, 'G');
INSERT INTO `Delivery_System`.`Payment_Method` (`Method_ID`, `Type`) VALUES (63, 'O');
INSERT INTO `Delivery_System`.`Payment_Method` (`Method_ID`, `Type`) VALUES (64, 'C');
INSERT INTO `Delivery_System`.`Payment_Method` (`Method_ID`, `Type`) VALUES (65, 'O');
INSERT INTO `Delivery_System`.`Payment_Method` (`Method_ID`, `Type`) VALUES (66, 'C');
INSERT INTO `Delivery_System`.`Payment_Method` (`Method_ID`, `Type`) VALUES (67, 'C');
INSERT INTO `Delivery_System`.`Payment_Method` (`Method_ID`, `Type`) VALUES (68, 'O');
INSERT INTO `Delivery_System`.`Payment_Method` (`Method_ID`, `Type`) VALUES (69, 'O');
INSERT INTO `Delivery_System`.`Payment_Method` (`Method_ID`, `Type`) VALUES (70, 'C');
INSERT INTO `Delivery_System`.`Payment_Method` (`Method_ID`, `Type`) VALUES (71, 'C');
INSERT INTO `Delivery_System`.`Payment_Method` (`Method_ID`, `Type`) VALUES (72, 'C');
INSERT INTO `Delivery_System`.`Payment_Method` (`Method_ID`, `Type`) VALUES (73, 'O');
INSERT INTO `Delivery_System`.`Payment_Method` (`Method_ID`, `Type`) VALUES (74, 'G');
INSERT INTO `Delivery_System`.`Payment_Method` (`Method_ID`, `Type`) VALUES (75, 'O');
INSERT INTO `Delivery_System`.`Payment_Method` (`Method_ID`, `Type`) VALUES (76, 'C');
INSERT INTO `Delivery_System`.`Payment_Method` (`Method_ID`, `Type`) VALUES (77, 'C');
INSERT INTO `Delivery_System`.`Payment_Method` (`Method_ID`, `Type`) VALUES (78, 'O');
INSERT INTO `Delivery_System`.`Payment_Method` (`Method_ID`, `Type`) VALUES (79, 'G');
INSERT INTO `Delivery_System`.`Payment_Method` (`Method_ID`, `Type`) VALUES (80, 'G');
INSERT INTO `Delivery_System`.`Payment_Method` (`Method_ID`, `Type`) VALUES (81, 'C');
INSERT INTO `Delivery_System`.`Payment_Method` (`Method_ID`, `Type`) VALUES (82, 'O');
INSERT INTO `Delivery_System`.`Payment_Method` (`Method_ID`, `Type`) VALUES (83, 'O');
INSERT INTO `Delivery_System`.`Payment_Method` (`Method_ID`, `Type`) VALUES (84, 'G');
INSERT INTO `Delivery_System`.`Payment_Method` (`Method_ID`, `Type`) VALUES (85, 'G');
INSERT INTO `Delivery_System`.`Payment_Method` (`Method_ID`, `Type`) VALUES (86, 'O');
INSERT INTO `Delivery_System`.`Payment_Method` (`Method_ID`, `Type`) VALUES (87, 'C');
INSERT INTO `Delivery_System`.`Payment_Method` (`Method_ID`, `Type`) VALUES (88, 'O');
INSERT INTO `Delivery_System`.`Payment_Method` (`Method_ID`, `Type`) VALUES (89, 'G');
INSERT INTO `Delivery_System`.`Payment_Method` (`Method_ID`, `Type`) VALUES (90, 'G');
INSERT INTO `Delivery_System`.`Payment_Method` (`Method_ID`, `Type`) VALUES (91, 'G');
INSERT INTO `Delivery_System`.`Payment_Method` (`Method_ID`, `Type`) VALUES (92, 'C');
INSERT INTO `Delivery_System`.`Payment_Method` (`Method_ID`, `Type`) VALUES (93, 'O');
INSERT INTO `Delivery_System`.`Payment_Method` (`Method_ID`, `Type`) VALUES (94, 'O');
INSERT INTO `Delivery_System`.`Payment_Method` (`Method_ID`, `Type`) VALUES (95, 'C');
INSERT INTO `Delivery_System`.`Payment_Method` (`Method_ID`, `Type`) VALUES (96, 'G');
INSERT INTO `Delivery_System`.`Payment_Method` (`Method_ID`, `Type`) VALUES (97, 'G');
INSERT INTO `Delivery_System`.`Payment_Method` (`Method_ID`, `Type`) VALUES (98, 'O');
INSERT INTO `Delivery_System`.`Payment_Method` (`Method_ID`, `Type`) VALUES (99, 'O');
INSERT INTO `Delivery_System`.`Payment_Method` (`Method_ID`, `Type`) VALUES (100, 'O');

COMMIT;


-- -----------------------------------------------------
-- Data for table `Delivery_System`.`Details`
-- -----------------------------------------------------
START TRANSACTION;
USE `Delivery_System`;
INSERT INTO `Delivery_System`.`Details` (`Method_ID`, `Cust_ID`, `Detail_ID`) VALUES (1, 1, '90001');
INSERT INTO `Delivery_System`.`Details` (`Method_ID`, `Cust_ID`, `Detail_ID`) VALUES (2, 2, '90002');
INSERT INTO `Delivery_System`.`Details` (`Method_ID`, `Cust_ID`, `Detail_ID`) VALUES (3, 3, '90003');
INSERT INTO `Delivery_System`.`Details` (`Method_ID`, `Cust_ID`, `Detail_ID`) VALUES (4, 4, '90004');
INSERT INTO `Delivery_System`.`Details` (`Method_ID`, `Cust_ID`, `Detail_ID`) VALUES (5, 5, '90005');
INSERT INTO `Delivery_System`.`Details` (`Method_ID`, `Cust_ID`, `Detail_ID`) VALUES (6, 6, '90006');
INSERT INTO `Delivery_System`.`Details` (`Method_ID`, `Cust_ID`, `Detail_ID`) VALUES (7, 7, '90007');
INSERT INTO `Delivery_System`.`Details` (`Method_ID`, `Cust_ID`, `Detail_ID`) VALUES (8, 8, '90008');
INSERT INTO `Delivery_System`.`Details` (`Method_ID`, `Cust_ID`, `Detail_ID`) VALUES (9, 9, '90009');
INSERT INTO `Delivery_System`.`Details` (`Method_ID`, `Cust_ID`, `Detail_ID`) VALUES (10, 10, '90010');
INSERT INTO `Delivery_System`.`Details` (`Method_ID`, `Cust_ID`, `Detail_ID`) VALUES (11, 11, '90011');
INSERT INTO `Delivery_System`.`Details` (`Method_ID`, `Cust_ID`, `Detail_ID`) VALUES (12, 12, '90012');
INSERT INTO `Delivery_System`.`Details` (`Method_ID`, `Cust_ID`, `Detail_ID`) VALUES (13, 13, '90013');
INSERT INTO `Delivery_System`.`Details` (`Method_ID`, `Cust_ID`, `Detail_ID`) VALUES (14, 14, '90014');
INSERT INTO `Delivery_System`.`Details` (`Method_ID`, `Cust_ID`, `Detail_ID`) VALUES (15, 15, '90015');
INSERT INTO `Delivery_System`.`Details` (`Method_ID`, `Cust_ID`, `Detail_ID`) VALUES (16, 16, '90016');
INSERT INTO `Delivery_System`.`Details` (`Method_ID`, `Cust_ID`, `Detail_ID`) VALUES (17, 17, '90017');
INSERT INTO `Delivery_System`.`Details` (`Method_ID`, `Cust_ID`, `Detail_ID`) VALUES (18, 18, '90018');
INSERT INTO `Delivery_System`.`Details` (`Method_ID`, `Cust_ID`, `Detail_ID`) VALUES (19, 19, '90019');
INSERT INTO `Delivery_System`.`Details` (`Method_ID`, `Cust_ID`, `Detail_ID`) VALUES (20, 20, '90020');
INSERT INTO `Delivery_System`.`Details` (`Method_ID`, `Cust_ID`, `Detail_ID`) VALUES (21, 21, '90021');
INSERT INTO `Delivery_System`.`Details` (`Method_ID`, `Cust_ID`, `Detail_ID`) VALUES (22, 22, '90022');
INSERT INTO `Delivery_System`.`Details` (`Method_ID`, `Cust_ID`, `Detail_ID`) VALUES (23, 23, '90023');
INSERT INTO `Delivery_System`.`Details` (`Method_ID`, `Cust_ID`, `Detail_ID`) VALUES (24, 24, '90024');
INSERT INTO `Delivery_System`.`Details` (`Method_ID`, `Cust_ID`, `Detail_ID`) VALUES (25, 25, '90025');
INSERT INTO `Delivery_System`.`Details` (`Method_ID`, `Cust_ID`, `Detail_ID`) VALUES (26, 26, '90026');
INSERT INTO `Delivery_System`.`Details` (`Method_ID`, `Cust_ID`, `Detail_ID`) VALUES (27, 27, '90027');
INSERT INTO `Delivery_System`.`Details` (`Method_ID`, `Cust_ID`, `Detail_ID`) VALUES (28, 28, '90028');
INSERT INTO `Delivery_System`.`Details` (`Method_ID`, `Cust_ID`, `Detail_ID`) VALUES (29, 29, '90029');
INSERT INTO `Delivery_System`.`Details` (`Method_ID`, `Cust_ID`, `Detail_ID`) VALUES (30, 30, '90030');
INSERT INTO `Delivery_System`.`Details` (`Method_ID`, `Cust_ID`, `Detail_ID`) VALUES (31, 31, '90031');
INSERT INTO `Delivery_System`.`Details` (`Method_ID`, `Cust_ID`, `Detail_ID`) VALUES (32, 32, '90032');
INSERT INTO `Delivery_System`.`Details` (`Method_ID`, `Cust_ID`, `Detail_ID`) VALUES (33, 33, '90033');
INSERT INTO `Delivery_System`.`Details` (`Method_ID`, `Cust_ID`, `Detail_ID`) VALUES (34, 34, '90034');
INSERT INTO `Delivery_System`.`Details` (`Method_ID`, `Cust_ID`, `Detail_ID`) VALUES (35, 35, '90035');
INSERT INTO `Delivery_System`.`Details` (`Method_ID`, `Cust_ID`, `Detail_ID`) VALUES (36, 36, '90036');
INSERT INTO `Delivery_System`.`Details` (`Method_ID`, `Cust_ID`, `Detail_ID`) VALUES (37, 37, '90037');
INSERT INTO `Delivery_System`.`Details` (`Method_ID`, `Cust_ID`, `Detail_ID`) VALUES (38, 38, '90038');
INSERT INTO `Delivery_System`.`Details` (`Method_ID`, `Cust_ID`, `Detail_ID`) VALUES (39, 39, '90039');
INSERT INTO `Delivery_System`.`Details` (`Method_ID`, `Cust_ID`, `Detail_ID`) VALUES (40, 40, '90040');
INSERT INTO `Delivery_System`.`Details` (`Method_ID`, `Cust_ID`, `Detail_ID`) VALUES (41, 41, '90041');
INSERT INTO `Delivery_System`.`Details` (`Method_ID`, `Cust_ID`, `Detail_ID`) VALUES (42, 42, '90042');
INSERT INTO `Delivery_System`.`Details` (`Method_ID`, `Cust_ID`, `Detail_ID`) VALUES (43, 43, '90043');
INSERT INTO `Delivery_System`.`Details` (`Method_ID`, `Cust_ID`, `Detail_ID`) VALUES (44, 44, '90044');
INSERT INTO `Delivery_System`.`Details` (`Method_ID`, `Cust_ID`, `Detail_ID`) VALUES (45, 45, '90045');
INSERT INTO `Delivery_System`.`Details` (`Method_ID`, `Cust_ID`, `Detail_ID`) VALUES (46, 46, '90046');
INSERT INTO `Delivery_System`.`Details` (`Method_ID`, `Cust_ID`, `Detail_ID`) VALUES (47, 47, '90047');
INSERT INTO `Delivery_System`.`Details` (`Method_ID`, `Cust_ID`, `Detail_ID`) VALUES (48, 48, '90048');
INSERT INTO `Delivery_System`.`Details` (`Method_ID`, `Cust_ID`, `Detail_ID`) VALUES (49, 49, '90049');
INSERT INTO `Delivery_System`.`Details` (`Method_ID`, `Cust_ID`, `Detail_ID`) VALUES (50, 50, '90050');
INSERT INTO `Delivery_System`.`Details` (`Method_ID`, `Cust_ID`, `Detail_ID`) VALUES (51, 51, '90051');
INSERT INTO `Delivery_System`.`Details` (`Method_ID`, `Cust_ID`, `Detail_ID`) VALUES (52, 52, '90052');
INSERT INTO `Delivery_System`.`Details` (`Method_ID`, `Cust_ID`, `Detail_ID`) VALUES (53, 53, '90053');
INSERT INTO `Delivery_System`.`Details` (`Method_ID`, `Cust_ID`, `Detail_ID`) VALUES (54, 54, '90054');
INSERT INTO `Delivery_System`.`Details` (`Method_ID`, `Cust_ID`, `Detail_ID`) VALUES (55, 55, '90055');
INSERT INTO `Delivery_System`.`Details` (`Method_ID`, `Cust_ID`, `Detail_ID`) VALUES (56, 56, '90056');
INSERT INTO `Delivery_System`.`Details` (`Method_ID`, `Cust_ID`, `Detail_ID`) VALUES (57, 57, '90057');
INSERT INTO `Delivery_System`.`Details` (`Method_ID`, `Cust_ID`, `Detail_ID`) VALUES (58, 58, '90058');
INSERT INTO `Delivery_System`.`Details` (`Method_ID`, `Cust_ID`, `Detail_ID`) VALUES (59, 59, '90059');
INSERT INTO `Delivery_System`.`Details` (`Method_ID`, `Cust_ID`, `Detail_ID`) VALUES (60, 60, '90060');
INSERT INTO `Delivery_System`.`Details` (`Method_ID`, `Cust_ID`, `Detail_ID`) VALUES (61, 61, '90061');
INSERT INTO `Delivery_System`.`Details` (`Method_ID`, `Cust_ID`, `Detail_ID`) VALUES (62, 62, '90062');
INSERT INTO `Delivery_System`.`Details` (`Method_ID`, `Cust_ID`, `Detail_ID`) VALUES (63, 63, '90063');
INSERT INTO `Delivery_System`.`Details` (`Method_ID`, `Cust_ID`, `Detail_ID`) VALUES (64, 64, '90064');
INSERT INTO `Delivery_System`.`Details` (`Method_ID`, `Cust_ID`, `Detail_ID`) VALUES (65, 65, '90065');
INSERT INTO `Delivery_System`.`Details` (`Method_ID`, `Cust_ID`, `Detail_ID`) VALUES (66, 66, '90066');
INSERT INTO `Delivery_System`.`Details` (`Method_ID`, `Cust_ID`, `Detail_ID`) VALUES (67, 67, '90067');
INSERT INTO `Delivery_System`.`Details` (`Method_ID`, `Cust_ID`, `Detail_ID`) VALUES (68, 68, '90068');
INSERT INTO `Delivery_System`.`Details` (`Method_ID`, `Cust_ID`, `Detail_ID`) VALUES (69, 69, '90069');
INSERT INTO `Delivery_System`.`Details` (`Method_ID`, `Cust_ID`, `Detail_ID`) VALUES (70, 70, '90070');
INSERT INTO `Delivery_System`.`Details` (`Method_ID`, `Cust_ID`, `Detail_ID`) VALUES (71, 71, '90071');
INSERT INTO `Delivery_System`.`Details` (`Method_ID`, `Cust_ID`, `Detail_ID`) VALUES (72, 72, '90072');
INSERT INTO `Delivery_System`.`Details` (`Method_ID`, `Cust_ID`, `Detail_ID`) VALUES (73, 73, '90073');
INSERT INTO `Delivery_System`.`Details` (`Method_ID`, `Cust_ID`, `Detail_ID`) VALUES (74, 74, '90074');
INSERT INTO `Delivery_System`.`Details` (`Method_ID`, `Cust_ID`, `Detail_ID`) VALUES (75, 75, '90075');
INSERT INTO `Delivery_System`.`Details` (`Method_ID`, `Cust_ID`, `Detail_ID`) VALUES (76, 76, '90076');
INSERT INTO `Delivery_System`.`Details` (`Method_ID`, `Cust_ID`, `Detail_ID`) VALUES (77, 77, '90077');
INSERT INTO `Delivery_System`.`Details` (`Method_ID`, `Cust_ID`, `Detail_ID`) VALUES (78, 78, '90078');
INSERT INTO `Delivery_System`.`Details` (`Method_ID`, `Cust_ID`, `Detail_ID`) VALUES (79, 79, '90079');
INSERT INTO `Delivery_System`.`Details` (`Method_ID`, `Cust_ID`, `Detail_ID`) VALUES (80, 80, '90080');
INSERT INTO `Delivery_System`.`Details` (`Method_ID`, `Cust_ID`, `Detail_ID`) VALUES (81, 81, '90081');
INSERT INTO `Delivery_System`.`Details` (`Method_ID`, `Cust_ID`, `Detail_ID`) VALUES (82, 82, '90082');
INSERT INTO `Delivery_System`.`Details` (`Method_ID`, `Cust_ID`, `Detail_ID`) VALUES (83, 83, '90083');
INSERT INTO `Delivery_System`.`Details` (`Method_ID`, `Cust_ID`, `Detail_ID`) VALUES (84, 84, '90084');
INSERT INTO `Delivery_System`.`Details` (`Method_ID`, `Cust_ID`, `Detail_ID`) VALUES (85, 85, '90085');
INSERT INTO `Delivery_System`.`Details` (`Method_ID`, `Cust_ID`, `Detail_ID`) VALUES (86, 86, '90086');
INSERT INTO `Delivery_System`.`Details` (`Method_ID`, `Cust_ID`, `Detail_ID`) VALUES (87, 87, '90087');
INSERT INTO `Delivery_System`.`Details` (`Method_ID`, `Cust_ID`, `Detail_ID`) VALUES (88, 88, '90088');
INSERT INTO `Delivery_System`.`Details` (`Method_ID`, `Cust_ID`, `Detail_ID`) VALUES (89, 89, '90089');
INSERT INTO `Delivery_System`.`Details` (`Method_ID`, `Cust_ID`, `Detail_ID`) VALUES (90, 90, '90090');
INSERT INTO `Delivery_System`.`Details` (`Method_ID`, `Cust_ID`, `Detail_ID`) VALUES (91, 91, '90091');
INSERT INTO `Delivery_System`.`Details` (`Method_ID`, `Cust_ID`, `Detail_ID`) VALUES (92, 92, '90092');
INSERT INTO `Delivery_System`.`Details` (`Method_ID`, `Cust_ID`, `Detail_ID`) VALUES (93, 93, '90093');
INSERT INTO `Delivery_System`.`Details` (`Method_ID`, `Cust_ID`, `Detail_ID`) VALUES (94, 94, '90094');
INSERT INTO `Delivery_System`.`Details` (`Method_ID`, `Cust_ID`, `Detail_ID`) VALUES (95, 95, '90095');
INSERT INTO `Delivery_System`.`Details` (`Method_ID`, `Cust_ID`, `Detail_ID`) VALUES (96, 96, '90096');
INSERT INTO `Delivery_System`.`Details` (`Method_ID`, `Cust_ID`, `Detail_ID`) VALUES (97, 97, '90097');
INSERT INTO `Delivery_System`.`Details` (`Method_ID`, `Cust_ID`, `Detail_ID`) VALUES (98, 98, '90098');
INSERT INTO `Delivery_System`.`Details` (`Method_ID`, `Cust_ID`, `Detail_ID`) VALUES (99, 99, '90099');
INSERT INTO `Delivery_System`.`Details` (`Method_ID`, `Cust_ID`, `Detail_ID`) VALUES (100, 100, '90100');

COMMIT;


-- -----------------------------------------------------
-- Data for table `Delivery_System`.`Invoice`
-- -----------------------------------------------------
START TRANSACTION;
USE `Delivery_System`;
INSERT INTO `Delivery_System`.`Invoice` (`Invoice_ID`, `Amount`, `Invoice_Status`, `Paid_Date`, `Detail_ID`, `OrderItem_ID`) VALUES (1, '2788.8', 'Paid', '2012-12-10', '90001', 100101);
INSERT INTO `Delivery_System`.`Invoice` (`Invoice_ID`, `Amount`, `Invoice_Status`, `Paid_Date`, `Detail_ID`, `OrderItem_ID`) VALUES (2, '3990', 'Paid', '2012-12-21', '90002', 100102);
INSERT INTO `Delivery_System`.`Invoice` (`Invoice_ID`, `Amount`, `Invoice_Status`, `Paid_Date`, `Detail_ID`, `OrderItem_ID`) VALUES (3, '2259.6', 'Paid', '2012-12-22', '90003', 100103);
INSERT INTO `Delivery_System`.`Invoice` (`Invoice_ID`, `Amount`, `Invoice_Status`, `Paid_Date`, `Detail_ID`, `OrderItem_ID`) VALUES (4, '564', 'Paid', '2012-12-24', '90004', 100104);
INSERT INTO `Delivery_System`.`Invoice` (`Invoice_ID`, `Amount`, `Invoice_Status`, `Paid_Date`, `Detail_ID`, `OrderItem_ID`) VALUES (5, '6158.4', 'Paid', '2012-12-25', '90005', 100105);
INSERT INTO `Delivery_System`.`Invoice` (`Invoice_ID`, `Amount`, `Invoice_Status`, `Paid_Date`, `Detail_ID`, `OrderItem_ID`) VALUES (6, '6408', 'Paid', '2012-12-27', '90006', 100106);
INSERT INTO `Delivery_System`.`Invoice` (`Invoice_ID`, `Amount`, `Invoice_Status`, `Paid_Date`, `Detail_ID`, `OrderItem_ID`) VALUES (7, '5319.6', 'Paid', '2013-01-09', '90007', 100107);
INSERT INTO `Delivery_System`.`Invoice` (`Invoice_ID`, `Amount`, `Invoice_Status`, `Paid_Date`, `Detail_ID`, `OrderItem_ID`) VALUES (8, '4196.4', 'Paid', '2013-01-10', '90008', 100108);
INSERT INTO `Delivery_System`.`Invoice` (`Invoice_ID`, `Amount`, `Invoice_Status`, `Paid_Date`, `Detail_ID`, `OrderItem_ID`) VALUES (9, '5145.6', 'Paid', '2013-01-24', '90009', 100109);
INSERT INTO `Delivery_System`.`Invoice` (`Invoice_ID`, `Amount`, `Invoice_Status`, `Paid_Date`, `Detail_ID`, `OrderItem_ID`) VALUES (10, '5622', 'Paid', '2013-02-04', '90010', 100110);
INSERT INTO `Delivery_System`.`Invoice` (`Invoice_ID`, `Amount`, `Invoice_Status`, `Paid_Date`, `Detail_ID`, `OrderItem_ID`) VALUES (11, '3225.6', 'Paid', '2013-02-12', '90011', 100111);
INSERT INTO `Delivery_System`.`Invoice` (`Invoice_ID`, `Amount`, `Invoice_Status`, `Paid_Date`, `Detail_ID`, `OrderItem_ID`) VALUES (12, '1194', 'Paid', '2013-02-24', '90012', 100112);
INSERT INTO `Delivery_System`.`Invoice` (`Invoice_ID`, `Amount`, `Invoice_Status`, `Paid_Date`, `Detail_ID`, `OrderItem_ID`) VALUES (13, '946.8', 'Paid', '2013-02-27', '90013', 100113);
INSERT INTO `Delivery_System`.`Invoice` (`Invoice_ID`, `Amount`, `Invoice_Status`, `Paid_Date`, `Detail_ID`, `OrderItem_ID`) VALUES (14, '480', 'Paid', '2013-03-08', '90014', 100114);
INSERT INTO `Delivery_System`.`Invoice` (`Invoice_ID`, `Amount`, `Invoice_Status`, `Paid_Date`, `Detail_ID`, `OrderItem_ID`) VALUES (15, '286.8', 'Paid', '2013-03-12', '90015', 100115);
INSERT INTO `Delivery_System`.`Invoice` (`Invoice_ID`, `Amount`, `Invoice_Status`, `Paid_Date`, `Detail_ID`, `OrderItem_ID`) VALUES (16, '5853.6', 'Paid', '2013-03-26', '90016', 100116);
INSERT INTO `Delivery_System`.`Invoice` (`Invoice_ID`, `Amount`, `Invoice_Status`, `Paid_Date`, `Detail_ID`, `OrderItem_ID`) VALUES (17, '6038.4', 'Paid', '2013-04-02', '90017', 100117);
INSERT INTO `Delivery_System`.`Invoice` (`Invoice_ID`, `Amount`, `Invoice_Status`, `Paid_Date`, `Detail_ID`, `OrderItem_ID`) VALUES (18, '6246', 'Paid', '2013-04-04', '90018', 100118);
INSERT INTO `Delivery_System`.`Invoice` (`Invoice_ID`, `Amount`, `Invoice_Status`, `Paid_Date`, `Detail_ID`, `OrderItem_ID`) VALUES (19, '3978', 'Paid', '2013-04-11', '90019', 100119);
INSERT INTO `Delivery_System`.`Invoice` (`Invoice_ID`, `Amount`, `Invoice_Status`, `Paid_Date`, `Detail_ID`, `OrderItem_ID`) VALUES (20, '807.6', 'Paid', '2013-04-12', '90020', 100120);
INSERT INTO `Delivery_System`.`Invoice` (`Invoice_ID`, `Amount`, `Invoice_Status`, `Paid_Date`, `Detail_ID`, `OrderItem_ID`) VALUES (21, '6160.8', 'Paid', '2013-04-13', '90021', 100121);
INSERT INTO `Delivery_System`.`Invoice` (`Invoice_ID`, `Amount`, `Invoice_Status`, `Paid_Date`, `Detail_ID`, `OrderItem_ID`) VALUES (22, '3127.2', 'Paid', '2013-04-28', '90022', 100122);
INSERT INTO `Delivery_System`.`Invoice` (`Invoice_ID`, `Amount`, `Invoice_Status`, `Paid_Date`, `Detail_ID`, `OrderItem_ID`) VALUES (23, '3532.8', 'Paid', '2013-04-29', '90023', 100123);
INSERT INTO `Delivery_System`.`Invoice` (`Invoice_ID`, `Amount`, `Invoice_Status`, `Paid_Date`, `Detail_ID`, `OrderItem_ID`) VALUES (24, '3304.8', 'Paid', '2013-05-28', '90024', 100124);
INSERT INTO `Delivery_System`.`Invoice` (`Invoice_ID`, `Amount`, `Invoice_Status`, `Paid_Date`, `Detail_ID`, `OrderItem_ID`) VALUES (25, '614.4', 'Paid', '2013-05-28', '90025', 100125);
INSERT INTO `Delivery_System`.`Invoice` (`Invoice_ID`, `Amount`, `Invoice_Status`, `Paid_Date`, `Detail_ID`, `OrderItem_ID`) VALUES (26, '5736', 'Paid', '2013-06-04', '90026', 100126);
INSERT INTO `Delivery_System`.`Invoice` (`Invoice_ID`, `Amount`, `Invoice_Status`, `Paid_Date`, `Detail_ID`, `OrderItem_ID`) VALUES (27, '948', 'Paid', '2013-07-02', '90027', 100127);
INSERT INTO `Delivery_System`.`Invoice` (`Invoice_ID`, `Amount`, `Invoice_Status`, `Paid_Date`, `Detail_ID`, `OrderItem_ID`) VALUES (28, '2844', 'Paid', '2013-07-23', '90028', 100128);
INSERT INTO `Delivery_System`.`Invoice` (`Invoice_ID`, `Amount`, `Invoice_Status`, `Paid_Date`, `Detail_ID`, `OrderItem_ID`) VALUES (29, '3061.2', 'Paid', '2013-07-25', '90029', 100129);
INSERT INTO `Delivery_System`.`Invoice` (`Invoice_ID`, `Amount`, `Invoice_Status`, `Paid_Date`, `Detail_ID`, `OrderItem_ID`) VALUES (30, '3232.8', 'Paid', '2013-08-10', '90030', 100130);
INSERT INTO `Delivery_System`.`Invoice` (`Invoice_ID`, `Amount`, `Invoice_Status`, `Paid_Date`, `Detail_ID`, `OrderItem_ID`) VALUES (31, '5875.2', 'Paid', '2013-08-14', '90031', 100131);
INSERT INTO `Delivery_System`.`Invoice` (`Invoice_ID`, `Amount`, `Invoice_Status`, `Paid_Date`, `Detail_ID`, `OrderItem_ID`) VALUES (32, '3772.8', 'Paid', '2013-08-19', '90032', 100132);
INSERT INTO `Delivery_System`.`Invoice` (`Invoice_ID`, `Amount`, `Invoice_Status`, `Paid_Date`, `Detail_ID`, `OrderItem_ID`) VALUES (33, '5037.6', 'Paid', '2013-08-20', '90033', 100133);
INSERT INTO `Delivery_System`.`Invoice` (`Invoice_ID`, `Amount`, `Invoice_Status`, `Paid_Date`, `Detail_ID`, `OrderItem_ID`) VALUES (34, '508.8', 'Paid', '2013-09-06', '90034', 100134);
INSERT INTO `Delivery_System`.`Invoice` (`Invoice_ID`, `Amount`, `Invoice_Status`, `Paid_Date`, `Detail_ID`, `OrderItem_ID`) VALUES (35, '5866.8', 'Paid', '2013-09-15', '90035', 100135);
INSERT INTO `Delivery_System`.`Invoice` (`Invoice_ID`, `Amount`, `Invoice_Status`, `Paid_Date`, `Detail_ID`, `OrderItem_ID`) VALUES (36, '3638.4', 'Paid', '2013-09-19', '90036', 100136);
INSERT INTO `Delivery_System`.`Invoice` (`Invoice_ID`, `Amount`, `Invoice_Status`, `Paid_Date`, `Detail_ID`, `OrderItem_ID`) VALUES (37, '2144.4', 'Paid', '2013-09-20', '90037', 100137);
INSERT INTO `Delivery_System`.`Invoice` (`Invoice_ID`, `Amount`, `Invoice_Status`, `Paid_Date`, `Detail_ID`, `OrderItem_ID`) VALUES (38, '3420', 'Paid', '2013-09-21', '90038', 100138);
INSERT INTO `Delivery_System`.`Invoice` (`Invoice_ID`, `Amount`, `Invoice_Status`, `Paid_Date`, `Detail_ID`, `OrderItem_ID`) VALUES (39, '1938', 'Paid', '2013-09-28', '90039', 100139);
INSERT INTO `Delivery_System`.`Invoice` (`Invoice_ID`, `Amount`, `Invoice_Status`, `Paid_Date`, `Detail_ID`, `OrderItem_ID`) VALUES (40, '574.8', 'Paid', '2013-10-08', '90040', 100140);
INSERT INTO `Delivery_System`.`Invoice` (`Invoice_ID`, `Amount`, `Invoice_Status`, `Paid_Date`, `Detail_ID`, `OrderItem_ID`) VALUES (41, '5317.2', 'Paid', '2013-10-10', '90041', 100141);
INSERT INTO `Delivery_System`.`Invoice` (`Invoice_ID`, `Amount`, `Invoice_Status`, `Paid_Date`, `Detail_ID`, `OrderItem_ID`) VALUES (42, '5595.6', 'Paid', '2013-10-12', '90042', 100142);
INSERT INTO `Delivery_System`.`Invoice` (`Invoice_ID`, `Amount`, `Invoice_Status`, `Paid_Date`, `Detail_ID`, `OrderItem_ID`) VALUES (43, '5757.6', 'Paid', '2013-10-14', '90043', 100143);
INSERT INTO `Delivery_System`.`Invoice` (`Invoice_ID`, `Amount`, `Invoice_Status`, `Paid_Date`, `Detail_ID`, `OrderItem_ID`) VALUES (44, '2074.8', 'Paid', '2013-10-16', '90044', 100144);
INSERT INTO `Delivery_System`.`Invoice` (`Invoice_ID`, `Amount`, `Invoice_Status`, `Paid_Date`, `Detail_ID`, `OrderItem_ID`) VALUES (45, '4905.6', 'Paid', '2013-10-29', '90045', 100145);
INSERT INTO `Delivery_System`.`Invoice` (`Invoice_ID`, `Amount`, `Invoice_Status`, `Paid_Date`, `Detail_ID`, `OrderItem_ID`) VALUES (46, '543.6', 'Paid', '2013-11-02', '90046', 100146);
INSERT INTO `Delivery_System`.`Invoice` (`Invoice_ID`, `Amount`, `Invoice_Status`, `Paid_Date`, `Detail_ID`, `OrderItem_ID`) VALUES (47, '934.8', 'Paid', '2013-11-02', '90047', 100147);
INSERT INTO `Delivery_System`.`Invoice` (`Invoice_ID`, `Amount`, `Invoice_Status`, `Paid_Date`, `Detail_ID`, `OrderItem_ID`) VALUES (48, '1141.2', 'Paid', '2013-11-15', '90048', 100148);
INSERT INTO `Delivery_System`.`Invoice` (`Invoice_ID`, `Amount`, `Invoice_Status`, `Paid_Date`, `Detail_ID`, `OrderItem_ID`) VALUES (49, '3516', 'Paid', '2013-12-20', '90049', 100149);
INSERT INTO `Delivery_System`.`Invoice` (`Invoice_ID`, `Amount`, `Invoice_Status`, `Paid_Date`, `Detail_ID`, `OrderItem_ID`) VALUES (50, '774', 'Paid', '2013-12-27', '90050', 100150);
INSERT INTO `Delivery_System`.`Invoice` (`Invoice_ID`, `Amount`, `Invoice_Status`, `Paid_Date`, `Detail_ID`, `OrderItem_ID`) VALUES (51, '2142', 'Paid', '2013-12-29', '90051', 100151);
INSERT INTO `Delivery_System`.`Invoice` (`Invoice_ID`, `Amount`, `Invoice_Status`, `Paid_Date`, `Detail_ID`, `OrderItem_ID`) VALUES (52, '5583.6', 'Paid', '2013-12-31', '90052', 100152);
INSERT INTO `Delivery_System`.`Invoice` (`Invoice_ID`, `Amount`, `Invoice_Status`, `Paid_Date`, `Detail_ID`, `OrderItem_ID`) VALUES (53, '5582.4', 'Paid', '2014-01-14', '90053', 100153);
INSERT INTO `Delivery_System`.`Invoice` (`Invoice_ID`, `Amount`, `Invoice_Status`, `Paid_Date`, `Detail_ID`, `OrderItem_ID`) VALUES (54, '5968.8', 'Paid', '2014-01-20', '90054', 100154);
INSERT INTO `Delivery_System`.`Invoice` (`Invoice_ID`, `Amount`, `Invoice_Status`, `Paid_Date`, `Detail_ID`, `OrderItem_ID`) VALUES (55, '3957.6', 'Paid', '2014-01-27', '90055', 100155);
INSERT INTO `Delivery_System`.`Invoice` (`Invoice_ID`, `Amount`, `Invoice_Status`, `Paid_Date`, `Detail_ID`, `OrderItem_ID`) VALUES (56, '5941.2', 'Paid', '2014-01-29', '90056', 100156);
INSERT INTO `Delivery_System`.`Invoice` (`Invoice_ID`, `Amount`, `Invoice_Status`, `Paid_Date`, `Detail_ID`, `OrderItem_ID`) VALUES (57, '1284', 'Paid', '2014-02-03', '90057', 100157);
INSERT INTO `Delivery_System`.`Invoice` (`Invoice_ID`, `Amount`, `Invoice_Status`, `Paid_Date`, `Detail_ID`, `OrderItem_ID`) VALUES (58, '6430.8', 'Paid', '2014-02-14', '90058', 100158);
INSERT INTO `Delivery_System`.`Invoice` (`Invoice_ID`, `Amount`, `Invoice_Status`, `Paid_Date`, `Detail_ID`, `OrderItem_ID`) VALUES (59, '2424', 'Paid', '2014-02-15', '90059', 100159);
INSERT INTO `Delivery_System`.`Invoice` (`Invoice_ID`, `Amount`, `Invoice_Status`, `Paid_Date`, `Detail_ID`, `OrderItem_ID`) VALUES (60, '477.6', 'Paid', '2014-03-25', '90060', 100160);
INSERT INTO `Delivery_System`.`Invoice` (`Invoice_ID`, `Amount`, `Invoice_Status`, `Paid_Date`, `Detail_ID`, `OrderItem_ID`) VALUES (61, '2572.8', 'Paid', '2014-03-25', '90061', 100161);
INSERT INTO `Delivery_System`.`Invoice` (`Invoice_ID`, `Amount`, `Invoice_Status`, `Paid_Date`, `Detail_ID`, `OrderItem_ID`) VALUES (62, '4861.2', 'Paid', '2014-04-08', '90062', 100162);
INSERT INTO `Delivery_System`.`Invoice` (`Invoice_ID`, `Amount`, `Invoice_Status`, `Paid_Date`, `Detail_ID`, `OrderItem_ID`) VALUES (63, '5341.2', 'Paid', '2014-04-14', '90063', 100163);
INSERT INTO `Delivery_System`.`Invoice` (`Invoice_ID`, `Amount`, `Invoice_Status`, `Paid_Date`, `Detail_ID`, `OrderItem_ID`) VALUES (64, '6348', 'Paid', '2014-05-15', '90064', 100164);
INSERT INTO `Delivery_System`.`Invoice` (`Invoice_ID`, `Amount`, `Invoice_Status`, `Paid_Date`, `Detail_ID`, `OrderItem_ID`) VALUES (65, '3670.8', 'Paid', '2014-05-19', '90065', 100165);
INSERT INTO `Delivery_System`.`Invoice` (`Invoice_ID`, `Amount`, `Invoice_Status`, `Paid_Date`, `Detail_ID`, `OrderItem_ID`) VALUES (66, '4821.6', 'Paid', '2014-05-22', '90066', 100166);
INSERT INTO `Delivery_System`.`Invoice` (`Invoice_ID`, `Amount`, `Invoice_Status`, `Paid_Date`, `Detail_ID`, `OrderItem_ID`) VALUES (67, '5283.6', 'Paid', '2014-06-22', '90067', 100167);
INSERT INTO `Delivery_System`.`Invoice` (`Invoice_ID`, `Amount`, `Invoice_Status`, `Paid_Date`, `Detail_ID`, `OrderItem_ID`) VALUES (68, '5742', 'Paid', '2014-06-27', '90068', 100168);
INSERT INTO `Delivery_System`.`Invoice` (`Invoice_ID`, `Amount`, `Invoice_Status`, `Paid_Date`, `Detail_ID`, `OrderItem_ID`) VALUES (69, '736.8', 'Paid', '2014-07-15', '90069', 100169);
INSERT INTO `Delivery_System`.`Invoice` (`Invoice_ID`, `Amount`, `Invoice_Status`, `Paid_Date`, `Detail_ID`, `OrderItem_ID`) VALUES (70, '5083.2', 'Paid', '2014-08-09', '90070', 100170);
INSERT INTO `Delivery_System`.`Invoice` (`Invoice_ID`, `Amount`, `Invoice_Status`, `Paid_Date`, `Detail_ID`, `OrderItem_ID`) VALUES (71, '6312', 'Paid', '2014-09-02', '90071', 100171);
INSERT INTO `Delivery_System`.`Invoice` (`Invoice_ID`, `Amount`, `Invoice_Status`, `Paid_Date`, `Detail_ID`, `OrderItem_ID`) VALUES (72, '390', 'Paid', '2014-09-03', '90072', 100172);
INSERT INTO `Delivery_System`.`Invoice` (`Invoice_ID`, `Amount`, `Invoice_Status`, `Paid_Date`, `Detail_ID`, `OrderItem_ID`) VALUES (73, '3187.2', 'Paid', '2014-09-04', '90073', 100173);
INSERT INTO `Delivery_System`.`Invoice` (`Invoice_ID`, `Amount`, `Invoice_Status`, `Paid_Date`, `Detail_ID`, `OrderItem_ID`) VALUES (74, '1806', 'Paid', '2014-09-05', '90074', 100174);
INSERT INTO `Delivery_System`.`Invoice` (`Invoice_ID`, `Amount`, `Invoice_Status`, `Paid_Date`, `Detail_ID`, `OrderItem_ID`) VALUES (75, '2246.4', 'Paid', '2014-09-21', '90075', 100175);
INSERT INTO `Delivery_System`.`Invoice` (`Invoice_ID`, `Amount`, `Invoice_Status`, `Paid_Date`, `Detail_ID`, `OrderItem_ID`) VALUES (76, '1353.6', 'Paid', '2014-09-25', '90076', 100176);
INSERT INTO `Delivery_System`.`Invoice` (`Invoice_ID`, `Amount`, `Invoice_Status`, `Paid_Date`, `Detail_ID`, `OrderItem_ID`) VALUES (77, '5328', 'Paid', '2014-09-25', '90077', 100177);
INSERT INTO `Delivery_System`.`Invoice` (`Invoice_ID`, `Amount`, `Invoice_Status`, `Paid_Date`, `Detail_ID`, `OrderItem_ID`) VALUES (78, '1038', 'Paid', '2014-09-28', '90078', 100178);
INSERT INTO `Delivery_System`.`Invoice` (`Invoice_ID`, `Amount`, `Invoice_Status`, `Paid_Date`, `Detail_ID`, `OrderItem_ID`) VALUES (79, '192', 'Paid', '2014-10-21', '90079', 100179);
INSERT INTO `Delivery_System`.`Invoice` (`Invoice_ID`, `Amount`, `Invoice_Status`, `Paid_Date`, `Detail_ID`, `OrderItem_ID`) VALUES (80, '3992.4', 'Paid', '2014-10-22', '90080', 100180);
INSERT INTO `Delivery_System`.`Invoice` (`Invoice_ID`, `Amount`, `Invoice_Status`, `Paid_Date`, `Detail_ID`, `OrderItem_ID`) VALUES (81, '5524.8', 'Paid', '2014-10-23', '90081', 100181);
INSERT INTO `Delivery_System`.`Invoice` (`Invoice_ID`, `Amount`, `Invoice_Status`, `Paid_Date`, `Detail_ID`, `OrderItem_ID`) VALUES (82, '1566', 'Paid', '2014-11-15', '90082', 100182);
INSERT INTO `Delivery_System`.`Invoice` (`Invoice_ID`, `Amount`, `Invoice_Status`, `Paid_Date`, `Detail_ID`, `OrderItem_ID`) VALUES (83, '2355.6', 'Paid', '2014-11-18', '90083', 100183);
INSERT INTO `Delivery_System`.`Invoice` (`Invoice_ID`, `Amount`, `Invoice_Status`, `Paid_Date`, `Detail_ID`, `OrderItem_ID`) VALUES (84, '206.4', 'Paid', '2014-11-28', '90084', 100184);
INSERT INTO `Delivery_System`.`Invoice` (`Invoice_ID`, `Amount`, `Invoice_Status`, `Paid_Date`, `Detail_ID`, `OrderItem_ID`) VALUES (85, '5618.4', 'Paid', '2015-01-07', '90085', 100185);
INSERT INTO `Delivery_System`.`Invoice` (`Invoice_ID`, `Amount`, `Invoice_Status`, `Paid_Date`, `Detail_ID`, `OrderItem_ID`) VALUES (86, '1161.6', 'Paid', '2015-01-08', '90086', 100186);
INSERT INTO `Delivery_System`.`Invoice` (`Invoice_ID`, `Amount`, `Invoice_Status`, `Paid_Date`, `Detail_ID`, `OrderItem_ID`) VALUES (87, '710.4', 'Paid', '2015-01-09', '90087', 100187);
INSERT INTO `Delivery_System`.`Invoice` (`Invoice_ID`, `Amount`, `Invoice_Status`, `Paid_Date`, `Detail_ID`, `OrderItem_ID`) VALUES (88, '1233.6', 'Paid', '2015-04-18', '90088', 100188);
INSERT INTO `Delivery_System`.`Invoice` (`Invoice_ID`, `Amount`, `Invoice_Status`, `Paid_Date`, `Detail_ID`, `OrderItem_ID`) VALUES (89, '765.6', 'Paid', '2015-04-23', '90089', 100189);
INSERT INTO `Delivery_System`.`Invoice` (`Invoice_ID`, `Amount`, `Invoice_Status`, `Paid_Date`, `Detail_ID`, `OrderItem_ID`) VALUES (90, '2332.8', 'Paid', '2015-04-25', '90090', 100190);
INSERT INTO `Delivery_System`.`Invoice` (`Invoice_ID`, `Amount`, `Invoice_Status`, `Paid_Date`, `Detail_ID`, `OrderItem_ID`) VALUES (91, '4858.8', 'Paid', '2015-04-26', '90091', 100191);
INSERT INTO `Delivery_System`.`Invoice` (`Invoice_ID`, `Amount`, `Invoice_Status`, `Paid_Date`, `Detail_ID`, `OrderItem_ID`) VALUES (92, '4867.2', 'Paid', '2015-04-26', '90092', 100192);
INSERT INTO `Delivery_System`.`Invoice` (`Invoice_ID`, `Amount`, `Invoice_Status`, `Paid_Date`, `Detail_ID`, `OrderItem_ID`) VALUES (93, '3476.4', 'Paid', '2015-04-26', '90093', 100193);
INSERT INTO `Delivery_System`.`Invoice` (`Invoice_ID`, `Amount`, `Invoice_Status`, `Paid_Date`, `Detail_ID`, `OrderItem_ID`) VALUES (94, '135.6', 'Paid', '2015-04-26', '90094', 100194);
INSERT INTO `Delivery_System`.`Invoice` (`Invoice_ID`, `Amount`, `Invoice_Status`, `Paid_Date`, `Detail_ID`, `OrderItem_ID`) VALUES (95, '5593.2', 'Paid', '2015-04-26', '90095', 100195);
INSERT INTO `Delivery_System`.`Invoice` (`Invoice_ID`, `Amount`, `Invoice_Status`, `Paid_Date`, `Detail_ID`, `OrderItem_ID`) VALUES (96, '3034.8', 'Paid', '2015-04-26', '90096', 100196);
INSERT INTO `Delivery_System`.`Invoice` (`Invoice_ID`, `Amount`, `Invoice_Status`, `Paid_Date`, `Detail_ID`, `OrderItem_ID`) VALUES (97, '4485.6', 'Paid', '2015-04-26', '90097', 100197);
INSERT INTO `Delivery_System`.`Invoice` (`Invoice_ID`, `Amount`, `Invoice_Status`, `Paid_Date`, `Detail_ID`, `OrderItem_ID`) VALUES (98, '2786.4', 'Paid', '2015-04-26', '90098', 100198);
INSERT INTO `Delivery_System`.`Invoice` (`Invoice_ID`, `Amount`, `Invoice_Status`, `Paid_Date`, `Detail_ID`, `OrderItem_ID`) VALUES (99, '5576.4', 'Paid', '2015-04-26', '90099', 100199);
INSERT INTO `Delivery_System`.`Invoice` (`Invoice_ID`, `Amount`, `Invoice_Status`, `Paid_Date`, `Detail_ID`, `OrderItem_ID`) VALUES (100, '6279.6', 'Paid', '2015-04-26', '90100', 100200);

COMMIT;


-- -----------------------------------------------------
-- Data for table `Delivery_System`.`Card_Details`
-- -----------------------------------------------------
START TRANSACTION;
USE `Delivery_System`;
INSERT INTO `Delivery_System`.`Card_Details` (`Card_No`, `Card_Name`, `CVV`, `Street_1`, `City`, `State`, `Zip`, `Method_ID`) VALUES ('3754056053577810', 'Malcolm G. Pugh', 475, '113-3670 Aliquet Ave', 'Birmingham', 'Alabama', 36094, 1);
INSERT INTO `Delivery_System`.`Card_Details` (`Card_No`, `Card_Name`, `CVV`, `Street_1`, `City`, `State`, `Zip`, `Method_ID`) VALUES ('5652545412326550', 'Vivien T. Waller', 874, 'Ap #138-2870 Integer Avenue', 'Lawton', 'OK', 46583, 40);
INSERT INTO `Delivery_System`.`Card_Details` (`Card_No`, `Card_Name`, `CVV`, `Street_1`, `City`, `State`, `Zip`, `Method_ID`) VALUES ('4221512221217210', 'Cameron B. Mcclain', 302, '110-1092 Risus. Road', 'Great Falls', 'Montana', 11110, 45);
INSERT INTO `Delivery_System`.`Card_Details` (`Card_No`, `Card_Name`, `CVV`, `Street_1`, `City`, `State`, `Zip`, `Method_ID`) VALUES ('3245678976852310', 'Amal W. Price', 177, '898-1197 Sed Street', 'Minneapolis', 'MN', 68013, 6);
INSERT INTO `Delivery_System`.`Card_Details` (`Card_No`, `Card_Name`, `CVV`, `Street_1`, `City`, `State`, `Zip`, `Method_ID`) VALUES ('3245675878906570', 'Sydnee I. Lucas', 773, '596-9805 Lacus St.', 'Mobile', 'AL', 35232, 28);
INSERT INTO `Delivery_System`.`Card_Details` (`Card_No`, `Card_Name`, `CVV`, `Street_1`, `City`, `State`, `Zip`, `Method_ID`) VALUES ('1234654367589860', 'Latifah L. Casey', 217, 'Ap #667-5049 Blandit Street', 'Hilo', 'HI', 81833, 60);
INSERT INTO `Delivery_System`.`Card_Details` (`Card_No`, `Card_Name`, `CVV`, `Street_1`, `City`, `State`, `Zip`, `Method_ID`) VALUES ('3210987067584560', 'Naomi Z. Randolph', 389, 'P.O. Box 540, 4620 Dui Road', 'Des Moines', 'Iowa', 67469, 23);
INSERT INTO `Delivery_System`.`Card_Details` (`Card_No`, `Card_Name`, `CVV`, `Street_1`, `City`, `State`, `Zip`, `Method_ID`) VALUES ('3245675876899800', 'Danielle P. Jensen', 560, '2585 Pellentesque, Ave', 'Aurora', 'Colorado', 59131, 16);
INSERT INTO `Delivery_System`.`Card_Details` (`Card_No`, `Card_Name`, `CVV`, `Street_1`, `City`, `State`, `Zip`, `Method_ID`) VALUES ('3332564776558790', 'Curran Q. Lambert', 457, '2534 Aliquam Street', 'Hilo', 'HI', 59656, 35);
INSERT INTO `Delivery_System`.`Card_Details` (`Card_No`, `Card_Name`, `CVV`, `Street_1`, `City`, `State`, `Zip`, `Method_ID`) VALUES ('2234677798077890', 'Xander O. Melton', 144, 'Ap #326-6551 Sit Avenue', 'Juneau', 'AK', 99919, 89);
INSERT INTO `Delivery_System`.`Card_Details` (`Card_No`, `Card_Name`, `CVV`, `Street_1`, `City`, `State`, `Zip`, `Method_ID`) VALUES ('1234432156788760', 'Kathleen S. Francis', 640, '3050 Risus. St.', 'Spokane', 'Washington', 27915, 72);
INSERT INTO `Delivery_System`.`Card_Details` (`Card_No`, `Card_Name`, `CVV`, `Street_1`, `City`, `State`, `Zip`, `Method_ID`) VALUES ('6754768987690980', 'Baker U. Holcomb', 706, 'Ap #301-9785 Fermentum Avenue', 'Gulfport', 'Mississippi', 53612, 66);
INSERT INTO `Delivery_System`.`Card_Details` (`Card_No`, `Card_Name`, `CVV`, `Street_1`, `City`, `State`, `Zip`, `Method_ID`) VALUES ('3256678967646570', 'Unity I. Charles', 680, 'P.O. Box 853, 7049 Adipiscing Rd.', 'Atlanta', 'GA', 64966, 52);

COMMIT;


-- -----------------------------------------------------
-- Data for table `Delivery_System`.`Online_Transaction`
-- -----------------------------------------------------
START TRANSACTION;
USE `Delivery_System`;
INSERT INTO `Delivery_System`.`Online_Transaction` (`Email_ID`, `Password`, `Method_ID`) VALUES ('Giselle.Browning@gmail.com', 'OCH09KDR1MU', 3);
INSERT INTO `Delivery_System`.`Online_Transaction` (`Email_ID`, `Password`, `Method_ID`) VALUES ('Allegra.Le@gmail.com', 'EZB17IWL3OK', 5);
INSERT INTO `Delivery_System`.`Online_Transaction` (`Email_ID`, `Password`, `Method_ID`) VALUES ('Darius.Frederick@gmail.com', 'RQD87DCV0PC', 6);
INSERT INTO `Delivery_System`.`Online_Transaction` (`Email_ID`, `Password`, `Method_ID`) VALUES ('Lane.Morse@gmail.com', 'IDY17HGR4IW', 8);
INSERT INTO `Delivery_System`.`Online_Transaction` (`Email_ID`, `Password`, `Method_ID`) VALUES ('Jillian.Patrick@gmail.com', 'BLF46NHE2VD', 11);
INSERT INTO `Delivery_System`.`Online_Transaction` (`Email_ID`, `Password`, `Method_ID`) VALUES ('Sybill.Rosa@gmail.com', 'KFB44CUK9SE', 13);
INSERT INTO `Delivery_System`.`Online_Transaction` (`Email_ID`, `Password`, `Method_ID`) VALUES ('Louis.Wade@gmail.com', 'IRW80CHV3TT', 16);
INSERT INTO `Delivery_System`.`Online_Transaction` (`Email_ID`, `Password`, `Method_ID`) VALUES ('Gloria.Woods@gmail.com', 'LYG94EKL1AJ', 17);
INSERT INTO `Delivery_System`.`Online_Transaction` (`Email_ID`, `Password`, `Method_ID`) VALUES ('Laura.Valdez@gmail.com', 'SWY18VPH7CD', 19);
INSERT INTO `Delivery_System`.`Online_Transaction` (`Email_ID`, `Password`, `Method_ID`) VALUES ('Kalia.Orr@gmail.com', 'AOQ10SJZ3GL', 20);
INSERT INTO `Delivery_System`.`Online_Transaction` (`Email_ID`, `Password`, `Method_ID`) VALUES ('Russell.Cameron@gmail.com', 'OWF70RXV8NQ', 22);
INSERT INTO `Delivery_System`.`Online_Transaction` (`Email_ID`, `Password`, `Method_ID`) VALUES ('Peter.Neal@gmail.com', 'EDK38GNB0VX', 23);
INSERT INTO `Delivery_System`.`Online_Transaction` (`Email_ID`, `Password`, `Method_ID`) VALUES ('Reed.Cruz@gmail.com', 'EBE98IMY5KT', 24);
INSERT INTO `Delivery_System`.`Online_Transaction` (`Email_ID`, `Password`, `Method_ID`) VALUES ('Griffith.Holland@gmail.com', 'OOA65LOU0SB', 29);
INSERT INTO `Delivery_System`.`Online_Transaction` (`Email_ID`, `Password`, `Method_ID`) VALUES ('Desirae.Fields@gmail.com', 'ZIA98AFT3RT', 30);
INSERT INTO `Delivery_System`.`Online_Transaction` (`Email_ID`, `Password`, `Method_ID`) VALUES ('Abra.Fuller@gmail.com', 'XTD78XSX5KM', 33);
INSERT INTO `Delivery_System`.`Online_Transaction` (`Email_ID`, `Password`, `Method_ID`) VALUES ('Piper.Blanchard@gmail.com', 'XYV19CZP8WP', 35);
INSERT INTO `Delivery_System`.`Online_Transaction` (`Email_ID`, `Password`, `Method_ID`) VALUES ('Adria.Olsen@gmail.com', 'EIH03ISW9RN', 37);
INSERT INTO `Delivery_System`.`Online_Transaction` (`Email_ID`, `Password`, `Method_ID`) VALUES ('Honorato.Cameron@gmail.com', 'RUB45UOH4QK', 40);
INSERT INTO `Delivery_System`.`Online_Transaction` (`Email_ID`, `Password`, `Method_ID`) VALUES ('Lareina.Leon@gmail.com', 'KQA66JMZ2JI', 41);
INSERT INTO `Delivery_System`.`Online_Transaction` (`Email_ID`, `Password`, `Method_ID`) VALUES ('Malcolm.Rhodes@gmail.com', 'RZO57CVT8AL', 42);
INSERT INTO `Delivery_System`.`Online_Transaction` (`Email_ID`, `Password`, `Method_ID`) VALUES ('Christine.Trujillo@gmail.com', 'MVZ57RHC6WQ', 43);
INSERT INTO `Delivery_System`.`Online_Transaction` (`Email_ID`, `Password`, `Method_ID`) VALUES ('Sarah.Porter@gmail.com', 'SMP18BBD5VF', 47);
INSERT INTO `Delivery_System`.`Online_Transaction` (`Email_ID`, `Password`, `Method_ID`) VALUES ('Brody.Moses@gmail.com', 'PFV96GUQ3AU', 52);
INSERT INTO `Delivery_System`.`Online_Transaction` (`Email_ID`, `Password`, `Method_ID`) VALUES ('Felicia.Reyes@gmail.com', 'VAE97MDV0ID', 53);
INSERT INTO `Delivery_System`.`Online_Transaction` (`Email_ID`, `Password`, `Method_ID`) VALUES ('Portia.Zimmerman@gmail.com', 'BFH10ZDB8HJ', 54);
INSERT INTO `Delivery_System`.`Online_Transaction` (`Email_ID`, `Password`, `Method_ID`) VALUES ('Fitzgerald.Mcclain@gmail.com', 'YQD57MMY2FQ', 55);
INSERT INTO `Delivery_System`.`Online_Transaction` (`Email_ID`, `Password`, `Method_ID`) VALUES ('Leila.Cardenas@gmail.com', 'VUA76ECQ9IX', 58);
INSERT INTO `Delivery_System`.`Online_Transaction` (`Email_ID`, `Password`, `Method_ID`) VALUES ('Timothy.Day@gmail.com', 'HFE37DFB9LR', 60);
INSERT INTO `Delivery_System`.`Online_Transaction` (`Email_ID`, `Password`, `Method_ID`) VALUES ('Dylan.Valdez@gmail.com', 'BFG36SYS6SF', 63);
INSERT INTO `Delivery_System`.`Online_Transaction` (`Email_ID`, `Password`, `Method_ID`) VALUES ('Zia.Salazar@gmail.com', 'VTX22FHT6TX', 65);
INSERT INTO `Delivery_System`.`Online_Transaction` (`Email_ID`, `Password`, `Method_ID`) VALUES ('Helen.Grant@gmail.com', 'ZYU95FGN9GF', 68);
INSERT INTO `Delivery_System`.`Online_Transaction` (`Email_ID`, `Password`, `Method_ID`) VALUES ('Tara.England@gmail.com', 'OPM59HDQ9OL', 69);
INSERT INTO `Delivery_System`.`Online_Transaction` (`Email_ID`, `Password`, `Method_ID`) VALUES ('Megan.Williams@gmail.com', 'QEC07ILI8JW', 73);
INSERT INTO `Delivery_System`.`Online_Transaction` (`Email_ID`, `Password`, `Method_ID`) VALUES ('Rajah.Rhodes@gmail.com', 'TVB43BGC3VB', 75);
INSERT INTO `Delivery_System`.`Online_Transaction` (`Email_ID`, `Password`, `Method_ID`) VALUES ('Demetrius.Norton@gmail.com', 'DTL49LDN4GV', 78);
INSERT INTO `Delivery_System`.`Online_Transaction` (`Email_ID`, `Password`, `Method_ID`) VALUES ('Nevada.Franklin@gmail.com', 'XWK96GYC7RZ', 82);
INSERT INTO `Delivery_System`.`Online_Transaction` (`Email_ID`, `Password`, `Method_ID`) VALUES ('Kylee.Holden@gmail.com', 'FRJ82HBB8EX', 83);
INSERT INTO `Delivery_System`.`Online_Transaction` (`Email_ID`, `Password`, `Method_ID`) VALUES ('Gregory.Carroll@gmail.com', 'JXY44ZRZ7YR', 86);
INSERT INTO `Delivery_System`.`Online_Transaction` (`Email_ID`, `Password`, `Method_ID`) VALUES ('Finn.Pace@gmail.com', 'DQQ20HNG3YF', 88);
INSERT INTO `Delivery_System`.`Online_Transaction` (`Email_ID`, `Password`, `Method_ID`) VALUES ('Latifah.Dominguez@gmail.com', 'LEH67PGI3BA', 93);
INSERT INTO `Delivery_System`.`Online_Transaction` (`Email_ID`, `Password`, `Method_ID`) VALUES ('Chaney.Keller@gmail.com', 'PMC65BOA4WA', 94);
INSERT INTO `Delivery_System`.`Online_Transaction` (`Email_ID`, `Password`, `Method_ID`) VALUES ('Winter.Ewing@gmail.com', 'PZY45VPQ7DS', 98);
INSERT INTO `Delivery_System`.`Online_Transaction` (`Email_ID`, `Password`, `Method_ID`) VALUES ('Deirdre.Mcconnell@gmail.com', 'SJT24QOH0MR', 99);

COMMIT;


-- -----------------------------------------------------
-- Data for table `Delivery_System`.`Gift_Card`
-- -----------------------------------------------------
START TRANSACTION;
USE `Delivery_System`;
INSERT INTO `Delivery_System`.`Gift_Card` (`Card_Num`, `Exp_Date`, `Method_ID`) VALUES ('k97o36na', '04-2012', 2);
INSERT INTO `Delivery_System`.`Gift_Card` (`Card_Num`, `Exp_Date`, `Method_ID`) VALUES ('vHtjyfhj', '05-2021', 7);
INSERT INTO `Delivery_System`.`Gift_Card` (`Card_Num`, `Exp_Date`, `Method_ID`) VALUES ('Zwz9nv3D', '01-2013', 10);
INSERT INTO `Delivery_System`.`Gift_Card` (`Card_Num`, `Exp_Date`, `Method_ID`) VALUES ('fnQjSchd', '06-2020', 14);
INSERT INTO `Delivery_System`.`Gift_Card` (`Card_Num`, `Exp_Date`, `Method_ID`) VALUES ('bwkBSExk', '03-2013', 18);
INSERT INTO `Delivery_System`.`Gift_Card` (`Card_Num`, `Exp_Date`, `Method_ID`) VALUES ('EMtZ7ztC', '12-2015', 21);
INSERT INTO `Delivery_System`.`Gift_Card` (`Card_Num`, `Exp_Date`, `Method_ID`) VALUES ('CthdZZxU', '02-2020', 25);
INSERT INTO `Delivery_System`.`Gift_Card` (`Card_Num`, `Exp_Date`, `Method_ID`) VALUES ('TRzuynDg', '09-2013', 26);
INSERT INTO `Delivery_System`.`Gift_Card` (`Card_Num`, `Exp_Date`, `Method_ID`) VALUES ('dRhGJquy', '08-2015', 27);
INSERT INTO `Delivery_System`.`Gift_Card` (`Card_Num`, `Exp_Date`, `Method_ID`) VALUES ('iomsCBYX', '11-2017', 31);
INSERT INTO `Delivery_System`.`Gift_Card` (`Card_Num`, `Exp_Date`, `Method_ID`) VALUES ('uxkejmoX', '02-2013', 32);
INSERT INTO `Delivery_System`.`Gift_Card` (`Card_Num`, `Exp_Date`, `Method_ID`) VALUES ('rJVaMUDa', '10-2014', 38);
INSERT INTO `Delivery_System`.`Gift_Card` (`Card_Num`, `Exp_Date`, `Method_ID`) VALUES ('JgpcYAcK', '08-2016', 44);
INSERT INTO `Delivery_System`.`Gift_Card` (`Card_Num`, `Exp_Date`, `Method_ID`) VALUES ('j9AQ53HY', '10-2016', 45);
INSERT INTO `Delivery_System`.`Gift_Card` (`Card_Num`, `Exp_Date`, `Method_ID`) VALUES ('i7ySgwMa', '05-2013', 51);
INSERT INTO `Delivery_System`.`Gift_Card` (`Card_Num`, `Exp_Date`, `Method_ID`) VALUES ('WzKcBFdR', '12-2017', 56);
INSERT INTO `Delivery_System`.`Gift_Card` (`Card_Num`, `Exp_Date`, `Method_ID`) VALUES ('uTPqRZDS', '01-2016', 57);
INSERT INTO `Delivery_System`.`Gift_Card` (`Card_Num`, `Exp_Date`, `Method_ID`) VALUES ('S4eTM6eY', '06-2020', 62);
INSERT INTO `Delivery_System`.`Gift_Card` (`Card_Num`, `Exp_Date`, `Method_ID`) VALUES ('JLukbVqv', '11-2020', 74);
INSERT INTO `Delivery_System`.`Gift_Card` (`Card_Num`, `Exp_Date`, `Method_ID`) VALUES ('StMb9g32', '10-2018', 79);
INSERT INTO `Delivery_System`.`Gift_Card` (`Card_Num`, `Exp_Date`, `Method_ID`) VALUES ('RwSYvUty', '08-2019', 80);
INSERT INTO `Delivery_System`.`Gift_Card` (`Card_Num`, `Exp_Date`, `Method_ID`) VALUES ('7pzNfLmp', '11-2020', 84);
INSERT INTO `Delivery_System`.`Gift_Card` (`Card_Num`, `Exp_Date`, `Method_ID`) VALUES ('yfrm3qdD', '03-2018', 85);
INSERT INTO `Delivery_System`.`Gift_Card` (`Card_Num`, `Exp_Date`, `Method_ID`) VALUES ('wmKKQ2DU', '02-2013', 89);
INSERT INTO `Delivery_System`.`Gift_Card` (`Card_Num`, `Exp_Date`, `Method_ID`) VALUES ('eMZVRnwh', '01-2019', 90);
INSERT INTO `Delivery_System`.`Gift_Card` (`Card_Num`, `Exp_Date`, `Method_ID`) VALUES ('kggU8mzE', '04-2019', 91);
INSERT INTO `Delivery_System`.`Gift_Card` (`Card_Num`, `Exp_Date`, `Method_ID`) VALUES ('fFRztxKV', '09-2018', 96);
INSERT INTO `Delivery_System`.`Gift_Card` (`Card_Num`, `Exp_Date`, `Method_ID`) VALUES ('Kad86ise', '05-2014', 97);

COMMIT;


-- -----------------------------------------------------
-- Data for table `Delivery_System`.`Department_has_Vendor`
-- -----------------------------------------------------
START TRANSACTION;
USE `Delivery_System`;
INSERT INTO `Delivery_System`.`Department_has_Vendor` (`Department_ID`, `Vendor_ID`) VALUES (101, 1001);
INSERT INTO `Delivery_System`.`Department_has_Vendor` (`Department_ID`, `Vendor_ID`) VALUES (101, 1002);
INSERT INTO `Delivery_System`.`Department_has_Vendor` (`Department_ID`, `Vendor_ID`) VALUES (101, 1006);
INSERT INTO `Delivery_System`.`Department_has_Vendor` (`Department_ID`, `Vendor_ID`) VALUES (101, 1007);
INSERT INTO `Delivery_System`.`Department_has_Vendor` (`Department_ID`, `Vendor_ID`) VALUES (101, 1015);
INSERT INTO `Delivery_System`.`Department_has_Vendor` (`Department_ID`, `Vendor_ID`) VALUES (102, 1003);
INSERT INTO `Delivery_System`.`Department_has_Vendor` (`Department_ID`, `Vendor_ID`) VALUES (102, 1004);
INSERT INTO `Delivery_System`.`Department_has_Vendor` (`Department_ID`, `Vendor_ID`) VALUES (103, 1003);
INSERT INTO `Delivery_System`.`Department_has_Vendor` (`Department_ID`, `Vendor_ID`) VALUES (103, 1004);
INSERT INTO `Delivery_System`.`Department_has_Vendor` (`Department_ID`, `Vendor_ID`) VALUES (103, 1005);
INSERT INTO `Delivery_System`.`Department_has_Vendor` (`Department_ID`, `Vendor_ID`) VALUES (103, 1008);
INSERT INTO `Delivery_System`.`Department_has_Vendor` (`Department_ID`, `Vendor_ID`) VALUES (103, 1009);
INSERT INTO `Delivery_System`.`Department_has_Vendor` (`Department_ID`, `Vendor_ID`) VALUES (103, 1014);
INSERT INTO `Delivery_System`.`Department_has_Vendor` (`Department_ID`, `Vendor_ID`) VALUES (104, 1003);
INSERT INTO `Delivery_System`.`Department_has_Vendor` (`Department_ID`, `Vendor_ID`) VALUES (105, 1004);
INSERT INTO `Delivery_System`.`Department_has_Vendor` (`Department_ID`, `Vendor_ID`) VALUES (105, 1010);
INSERT INTO `Delivery_System`.`Department_has_Vendor` (`Department_ID`, `Vendor_ID`) VALUES (105, 1011);
INSERT INTO `Delivery_System`.`Department_has_Vendor` (`Department_ID`, `Vendor_ID`) VALUES (107, 1008);
INSERT INTO `Delivery_System`.`Department_has_Vendor` (`Department_ID`, `Vendor_ID`) VALUES (107, 1009);

COMMIT;


-- -----------------------------------------------------
-- Data for table `Delivery_System`.`Feedback`
-- -----------------------------------------------------
START TRANSACTION;
USE `Delivery_System`;
INSERT INTO `Delivery_System`.`Feedback` (`Feedback_ID`, `Product_Rating`, `Feedback_Description`, `Date`, `Cust_ID`, `Model_Number`) VALUES (1, 1, 'hendrerit a, arcu. Sed et libero. Proin mi. Aliquam gravida mauris ut mi. Duis risus', '2012-06-12', 1, 7789276);
INSERT INTO `Delivery_System`.`Feedback` (`Feedback_ID`, `Product_Rating`, `Feedback_Description`, `Date`, `Cust_ID`, `Model_Number`) VALUES (2, 4, 'non enim commodo hendrerit. Donec porttitor tellus non magna. Nam ligula elit, pretium et, rutrum', '2012-06-13', 3, 7789215);
INSERT INTO `Delivery_System`.`Feedback` (`Feedback_ID`, `Product_Rating`, `Feedback_Description`, `Date`, `Cust_ID`, `Model_Number`) VALUES (3, 5, 'facilisi. Sed neque. Sed eget lacus. Mauris non dui nec urna suscipit nonummy. Fusce fermentum', '2012-07-04', 85, 7789216);
INSERT INTO `Delivery_System`.`Feedback` (`Feedback_ID`, `Product_Rating`, `Feedback_Description`, `Date`, `Cust_ID`, `Model_Number`) VALUES (4, 1, 'ipsum non arcu. Vivamus sit amet risus. Donec egestas. Aliquam nec enim. Nunc ut erat.', '2012-07-12', 56, 7789223);
INSERT INTO `Delivery_System`.`Feedback` (`Feedback_ID`, `Product_Rating`, `Feedback_Description`, `Date`, `Cust_ID`, `Model_Number`) VALUES (5, 2, 'mauris. Integer sem elit, pharetra ut, pharetra sed, hendrerit a, arcu. Sed et libero. Proin', '2012-08-22', 4, 7789218);
INSERT INTO `Delivery_System`.`Feedback` (`Feedback_ID`, `Product_Rating`, `Feedback_Description`, `Date`, `Cust_ID`, `Model_Number`) VALUES (6, 2, 'sit amet, consectetuer adipiscing elit. Curabitur sed tortor. Integer aliquam adipiscing lacus. Ut nec urna', '2012-08-29', 89, 7789219);
INSERT INTO `Delivery_System`.`Feedback` (`Feedback_ID`, `Product_Rating`, `Feedback_Description`, `Date`, `Cust_ID`, `Model_Number`) VALUES (7, 1, 'eleifend non, dapibus rutrum, justo. Praesent luctus. Curabitur egestas nunc sed libero. Proin sed turpis', '2012-09-22', 41, 7789210);
INSERT INTO `Delivery_System`.`Feedback` (`Feedback_ID`, `Product_Rating`, `Feedback_Description`, `Date`, `Cust_ID`, `Model_Number`) VALUES (8, 1, 'Duis at lacus. Quisque purus sapien, gravida non, sollicitudin a, malesuada id, erat. Etiam vestibulum', '2012-09-30', 32, 7789223);
INSERT INTO `Delivery_System`.`Feedback` (`Feedback_ID`, `Product_Rating`, `Feedback_Description`, `Date`, `Cust_ID`, `Model_Number`) VALUES (9, 2, 'adipiscing ligula. Aenean gravida nunc sed pede. Cum sociis natoque penatibus et magnis dis parturient', '2012-10-11', 69, 7789223);
INSERT INTO `Delivery_System`.`Feedback` (`Feedback_ID`, `Product_Rating`, `Feedback_Description`, `Date`, `Cust_ID`, `Model_Number`) VALUES (10, 4, 'risus, at fringilla purus mauris a nunc. In at pede. Cras vulputate velit eu sem.', '2012-10-30', 30, 7789223);
INSERT INTO `Delivery_System`.`Feedback` (`Feedback_ID`, `Product_Rating`, `Feedback_Description`, `Date`, `Cust_ID`, `Model_Number`) VALUES (11, 3, 'rhoncus. Nullam velit dui, semper et, lacinia vitae, sodales at, velit. Pellentesque ultricies dignissim lacus.', '2012-11-07', 5, 7789224);
INSERT INTO `Delivery_System`.`Feedback` (`Feedback_ID`, `Product_Rating`, `Feedback_Description`, `Date`, `Cust_ID`, `Model_Number`) VALUES (12, 5, 'scelerisque mollis. Phasellus libero mauris, aliquam eu, accumsan sed, facilisis vitae, orci. Phasellus dapibus quam', '2012-11-15', 26, 7789225);
INSERT INTO `Delivery_System`.`Feedback` (`Feedback_ID`, `Product_Rating`, `Feedback_Description`, `Date`, `Cust_ID`, `Model_Number`) VALUES (13, 1, 'amet luctus vulputate, nisi sem semper erat, in consectetuer ipsum nunc id enim. Curabitur massa.', '2012-11-19', 69, 7789226);
INSERT INTO `Delivery_System`.`Feedback` (`Feedback_ID`, `Product_Rating`, `Feedback_Description`, `Date`, `Cust_ID`, `Model_Number`) VALUES (14, 4, 'Fusce dolor quam, elementum at, egestas a, scelerisque sed, sapien. Nunc pulvinar arcu et pede.', '2012-11-30', 45, 7789227);
INSERT INTO `Delivery_System`.`Feedback` (`Feedback_ID`, `Product_Rating`, `Feedback_Description`, `Date`, `Cust_ID`, `Model_Number`) VALUES (15, 3, 'fringilla mi lacinia mattis. Integer eu lacus. Quisque imperdiet, erat nonummy ultricies ornare, elit elit', '2012-12-14', 50, 7789228);
INSERT INTO `Delivery_System`.`Feedback` (`Feedback_ID`, `Product_Rating`, `Feedback_Description`, `Date`, `Cust_ID`, `Model_Number`) VALUES (16, 1, 'Nunc mauris sapien, cursus in, hendrerit consectetuer, cursus et, magna. Praesent interdum ligula eu enim.', '2012-12-15', 73, 7789229);
INSERT INTO `Delivery_System`.`Feedback` (`Feedback_ID`, `Product_Rating`, `Feedback_Description`, `Date`, `Cust_ID`, `Model_Number`) VALUES (17, 1, 'ipsum ac mi eleifend egestas. Sed pharetra, felis eget varius ultrices, mauris ipsum porta elit,', '2013-01-07', 41, 7789230);
INSERT INTO `Delivery_System`.`Feedback` (`Feedback_ID`, `Product_Rating`, `Feedback_Description`, `Date`, `Cust_ID`, `Model_Number`) VALUES (18, 3, 'eget mollis lectus pede et risus. Quisque libero lacus, varius et, euismod et, commodo at,', '2013-01-16', 62, 7789245);
INSERT INTO `Delivery_System`.`Feedback` (`Feedback_ID`, `Product_Rating`, `Feedback_Description`, `Date`, `Cust_ID`, `Model_Number`) VALUES (19, 5, 'Proin nisl sem, consequat nec, mollis vitae, posuere at, velit. Cras lorem lorem, luctus ut,', '2013-01-16', 23, 7789210);
INSERT INTO `Delivery_System`.`Feedback` (`Feedback_ID`, `Product_Rating`, `Feedback_Description`, `Date`, `Cust_ID`, `Model_Number`) VALUES (20, 4, 'justo sit amet nulla. Donec non justo. Proin non massa non ante bibendum ullamcorper. Duis', '2013-01-23', 29, 7789201);
INSERT INTO `Delivery_System`.`Feedback` (`Feedback_ID`, `Product_Rating`, `Feedback_Description`, `Date`, `Cust_ID`, `Model_Number`) VALUES (21, 5, 'risus. Duis a mi fringilla mi lacinia mattis. Integer eu lacus. Quisque imperdiet, erat nonummy', '2013-02-08', 76, 7789202);
INSERT INTO `Delivery_System`.`Feedback` (`Feedback_ID`, `Product_Rating`, `Feedback_Description`, `Date`, `Cust_ID`, `Model_Number`) VALUES (22, 2, 'pede. Cum sociis natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus. Proin vel', '2013-02-09', 89, 7789281);
INSERT INTO `Delivery_System`.`Feedback` (`Feedback_ID`, `Product_Rating`, `Feedback_Description`, `Date`, `Cust_ID`, `Model_Number`) VALUES (23, 2, 'eleifend non, dapibus rutrum, justo. Praesent luctus. Curabitur egestas nunc sed libero. Proin sed turpis', '2013-02-19', 12, 7789204);
INSERT INTO `Delivery_System`.`Feedback` (`Feedback_ID`, `Product_Rating`, `Feedback_Description`, `Date`, `Cust_ID`, `Model_Number`) VALUES (24, 3, 'ut odio vel est tempor bibendum. Donec felis orci, adipiscing non, luctus sit amet, faucibus', '2013-02-25', 19, 7789276);
INSERT INTO `Delivery_System`.`Feedback` (`Feedback_ID`, `Product_Rating`, `Feedback_Description`, `Date`, `Cust_ID`, `Model_Number`) VALUES (25, 3, 'Cras convallis convallis dolor. Quisque tincidunt pede ac urna. Ut tincidunt vehicula risus. Nulla eget', '2013-03-04', 40, 7789206);
INSERT INTO `Delivery_System`.`Feedback` (`Feedback_ID`, `Product_Rating`, `Feedback_Description`, `Date`, `Cust_ID`, `Model_Number`) VALUES (26, 4, 'lorem, sit amet ultricies sem magna nec quam. Curabitur vel lectus. Cum sociis natoque penatibus', '2013-04-01', 80, 7789281);
INSERT INTO `Delivery_System`.`Feedback` (`Feedback_ID`, `Product_Rating`, `Feedback_Description`, `Date`, `Cust_ID`, `Model_Number`) VALUES (27, 3, 'dolor dolor, tempus non, lacinia at, iaculis quis, pede. Praesent eu dui. Cum sociis natoque', '2013-04-04', 34, 7789208);
INSERT INTO `Delivery_System`.`Feedback` (`Feedback_ID`, `Product_Rating`, `Feedback_Description`, `Date`, `Cust_ID`, `Model_Number`) VALUES (28, 5, 'auctor non, feugiat nec, diam. Duis mi enim, condimentum eget, volutpat ornare, facilisis eget, ipsum.', '2013-04-12', 9, 7789209);
INSERT INTO `Delivery_System`.`Feedback` (`Feedback_ID`, `Product_Rating`, `Feedback_Description`, `Date`, `Cust_ID`, `Model_Number`) VALUES (29, 1, 'ipsum non arcu. Vivamus sit amet risus. Donec egestas. Aliquam nec enim. Nunc ut erat.', '2013-04-20', 10, 7789210);
INSERT INTO `Delivery_System`.`Feedback` (`Feedback_ID`, `Product_Rating`, `Feedback_Description`, `Date`, `Cust_ID`, `Model_Number`) VALUES (30, 2, 'Fusce mollis. Duis sit amet diam eu dolor egestas rhoncus. Proin nisl sem, consequat nec,', '2013-05-03', 84, 7789204);
INSERT INTO `Delivery_System`.`Feedback` (`Feedback_ID`, `Product_Rating`, `Feedback_Description`, `Date`, `Cust_ID`, `Model_Number`) VALUES (31, 3, 'vel, mauris. Integer sem elit, pharetra ut, pharetra sed, hendrerit a, arcu. Sed et libero.', '2013-05-29', 31, 7789212);
INSERT INTO `Delivery_System`.`Feedback` (`Feedback_ID`, `Product_Rating`, `Feedback_Description`, `Date`, `Cust_ID`, `Model_Number`) VALUES (32, 4, 'massa. Integer vitae nibh. Donec est mauris, rhoncus id, mollis nec, cursus a, enim. Suspendisse', '2013-06-11', 64, 7789213);
INSERT INTO `Delivery_System`.`Feedback` (`Feedback_ID`, `Product_Rating`, `Feedback_Description`, `Date`, `Cust_ID`, `Model_Number`) VALUES (33, 3, 'imperdiet dictum magna. Ut tincidunt orci quis lectus. Nullam suscipit, est ac facilisis facilisis, magna', '2013-06-14', 59, 7789233);
INSERT INTO `Delivery_System`.`Feedback` (`Feedback_ID`, `Product_Rating`, `Feedback_Description`, `Date`, `Cust_ID`, `Model_Number`) VALUES (34, 2, 'nec, eleifend non, dapibus rutrum, justo. Praesent luctus. Curabitur egestas nunc sed libero. Proin sed', '2013-06-15', 21, 7789245);
INSERT INTO `Delivery_System`.`Feedback` (`Feedback_ID`, `Product_Rating`, `Feedback_Description`, `Date`, `Cust_ID`, `Model_Number`) VALUES (35, 1, 'non, egestas a, dui. Cras pellentesque. Sed dictum. Proin eget odio. Aliquam vulputate ullamcorper magna.', '2013-07-01', 86, 7789245);
INSERT INTO `Delivery_System`.`Feedback` (`Feedback_ID`, `Product_Rating`, `Feedback_Description`, `Date`, `Cust_ID`, `Model_Number`) VALUES (36, 3, 'in, hendrerit consectetuer, cursus et, magna. Praesent interdum ligula eu enim. Etiam imperdiet dictum magna.', '2013-07-09', 67, 7789236);
INSERT INTO `Delivery_System`.`Feedback` (`Feedback_ID`, `Product_Rating`, `Feedback_Description`, `Date`, `Cust_ID`, `Model_Number`) VALUES (37, 1, 'natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus. Aenean eget magna. Suspendisse tristique', '2013-07-20', 21, 7789237);
INSERT INTO `Delivery_System`.`Feedback` (`Feedback_ID`, `Product_Rating`, `Feedback_Description`, `Date`, `Cust_ID`, `Model_Number`) VALUES (38, 1, 'est ac facilisis facilisis, magna tellus faucibus leo, in lobortis tellus justo sit amet nulla.', '2013-08-02', 69, 7789245);
INSERT INTO `Delivery_System`.`Feedback` (`Feedback_ID`, `Product_Rating`, `Feedback_Description`, `Date`, `Cust_ID`, `Model_Number`) VALUES (39, 2, 'vel sapien imperdiet ornare. In faucibus. Morbi vehicula. Pellentesque tincidunt tempus risus. Donec egestas. Duis', '2013-08-08', 30, 7789239);
INSERT INTO `Delivery_System`.`Feedback` (`Feedback_ID`, `Product_Rating`, `Feedback_Description`, `Date`, `Cust_ID`, `Model_Number`) VALUES (40, 4, 'mus. Proin vel nisl. Quisque fringilla euismod enim. Etiam gravida molestie arcu. Sed eu nibh', '2013-08-23', 5, 7789240);
INSERT INTO `Delivery_System`.`Feedback` (`Feedback_ID`, `Product_Rating`, `Feedback_Description`, `Date`, `Cust_ID`, `Model_Number`) VALUES (41, 4, 'Duis dignissim tempor arcu. Vestibulum ut eros non enim commodo hendrerit. Donec porttitor tellus non', '2013-08-29', 26, 7789241);
INSERT INTO `Delivery_System`.`Feedback` (`Feedback_ID`, `Product_Rating`, `Feedback_Description`, `Date`, `Cust_ID`, `Model_Number`) VALUES (42, 4, 'eu dui. Cum sociis natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus. Aenean', '2013-10-02', 69, 7789210);
INSERT INTO `Delivery_System`.`Feedback` (`Feedback_ID`, `Product_Rating`, `Feedback_Description`, `Date`, `Cust_ID`, `Model_Number`) VALUES (43, 5, 'augue eu tellus. Phasellus elit pede, malesuada vel, venenatis vel, faucibus id, libero. Donec consectetuer', '2013-11-13', 45, 7789243);
INSERT INTO `Delivery_System`.`Feedback` (`Feedback_ID`, `Product_Rating`, `Feedback_Description`, `Date`, `Cust_ID`, `Model_Number`) VALUES (44, 3, 'vel quam dignissim pharetra. Nam ac nulla. In tincidunt congue turpis. In condimentum. Donec at', '2013-11-29', 50, 7789244);
INSERT INTO `Delivery_System`.`Feedback` (`Feedback_ID`, `Product_Rating`, `Feedback_Description`, `Date`, `Cust_ID`, `Model_Number`) VALUES (45, 4, 'placerat, augue. Sed molestie. Sed id risus quis diam luctus lobortis. Class aptent taciti sociosqu', '2013-12-06', 73, 7789245);
INSERT INTO `Delivery_System`.`Feedback` (`Feedback_ID`, `Product_Rating`, `Feedback_Description`, `Date`, `Cust_ID`, `Model_Number`) VALUES (46, 3, 'Phasellus in felis. Nulla tempor augue ac ipsum. Phasellus vitae mauris sit amet lorem semper', '2013-12-11', 41, 7789246);
INSERT INTO `Delivery_System`.`Feedback` (`Feedback_ID`, `Product_Rating`, `Feedback_Description`, `Date`, `Cust_ID`, `Model_Number`) VALUES (47, 3, 'quis, pede. Suspendisse dui. Fusce diam nunc, ullamcorper eu, euismod ac, fermentum vel, mauris. Integer', '2014-01-09', 7, 7789247);
INSERT INTO `Delivery_System`.`Feedback` (`Feedback_ID`, `Product_Rating`, `Feedback_Description`, `Date`, `Cust_ID`, `Model_Number`) VALUES (48, 1, 'sodales. Mauris blandit enim consequat purus. Maecenas libero est, congue a, aliquet vel, vulputate eu,', '2014-01-11', 8, 7789248);
INSERT INTO `Delivery_System`.`Feedback` (`Feedback_ID`, `Product_Rating`, `Feedback_Description`, `Date`, `Cust_ID`, `Model_Number`) VALUES (49, 2, 'Nullam scelerisque neque sed sem egestas blandit. Nam nulla magna, malesuada vel, convallis in, cursus', '2014-01-29', 89, 7789210);
INSERT INTO `Delivery_System`.`Feedback` (`Feedback_ID`, `Product_Rating`, `Feedback_Description`, `Date`, `Cust_ID`, `Model_Number`) VALUES (50, 5, 'quis diam luctus lobortis. Class aptent taciti sociosqu ad litora torquent per conubia nostra, per', '2014-01-30', 54, 7789250);
INSERT INTO `Delivery_System`.`Feedback` (`Feedback_ID`, `Product_Rating`, `Feedback_Description`, `Date`, `Cust_ID`, `Model_Number`) VALUES (51, 3, 'magna. Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Etiam laoreet, libero et tristique pellentesque,', '2014-03-03', 56, 7789251);
INSERT INTO `Delivery_System`.`Feedback` (`Feedback_ID`, `Product_Rating`, `Feedback_Description`, `Date`, `Cust_ID`, `Model_Number`) VALUES (52, 1, 'Aliquam fringilla cursus purus. Nullam scelerisque neque sed sem egestas blandit. Nam nulla magna, malesuada', '2014-03-06', 8, 7789298);
INSERT INTO `Delivery_System`.`Feedback` (`Feedback_ID`, `Product_Rating`, `Feedback_Description`, `Date`, `Cust_ID`, `Model_Number`) VALUES (53, 4, 'elit elit fermentum risus, at fringilla purus mauris a nunc. In at pede. Cras vulputate', '2014-03-23', 8, 7789253);
INSERT INTO `Delivery_System`.`Feedback` (`Feedback_ID`, `Product_Rating`, `Feedback_Description`, `Date`, `Cust_ID`, `Model_Number`) VALUES (54, 3, 'ullamcorper viverra. Maecenas iaculis aliquet diam. Sed diam lorem, auctor quis, tristique ac, eleifend vitae,', '2014-03-29', 25, 7789254);
INSERT INTO `Delivery_System`.`Feedback` (`Feedback_ID`, `Product_Rating`, `Feedback_Description`, `Date`, `Cust_ID`, `Model_Number`) VALUES (55, 4, 'ultricies adipiscing, enim mi tempor lorem, eget mollis lectus pede et risus. Quisque libero lacus,', '2014-03-29', 86, 7789255);
INSERT INTO `Delivery_System`.`Feedback` (`Feedback_ID`, `Product_Rating`, `Feedback_Description`, `Date`, `Cust_ID`, `Model_Number`) VALUES (56, 5, 'ac arcu. Nunc mauris. Morbi non sapien molestie orci tincidunt adipiscing. Mauris molestie pharetra nibh.', '2014-03-30', 30, 7789256);
INSERT INTO `Delivery_System`.`Feedback` (`Feedback_ID`, `Product_Rating`, `Feedback_Description`, `Date`, `Cust_ID`, `Model_Number`) VALUES (57, 2, 'orci. Ut semper pretium neque. Morbi quis urna. Nunc quis arcu vel quam dignissim pharetra.', '2014-04-10', 5, 7789257);
INSERT INTO `Delivery_System`.`Feedback` (`Feedback_ID`, `Product_Rating`, `Feedback_Description`, `Date`, `Cust_ID`, `Model_Number`) VALUES (58, 5, 'aliquam adipiscing lacus. Ut nec urna et arcu imperdiet ullamcorper. Duis at lacus. Quisque purus', '2014-04-18', 26, 7789298);
INSERT INTO `Delivery_System`.`Feedback` (`Feedback_ID`, `Product_Rating`, `Feedback_Description`, `Date`, `Cust_ID`, `Model_Number`) VALUES (59, 4, 'eu dolor egestas rhoncus. Proin nisl sem, consequat nec, mollis vitae, posuere at, velit. Cras', '2014-04-23', 69, 7789259);
INSERT INTO `Delivery_System`.`Feedback` (`Feedback_ID`, `Product_Rating`, `Feedback_Description`, `Date`, `Cust_ID`, `Model_Number`) VALUES (60, 3, 'Morbi quis urna. Nunc quis arcu vel quam dignissim pharetra. Nam ac nulla. In tincidunt', '2014-04-24', 45, 7789260);
INSERT INTO `Delivery_System`.`Feedback` (`Feedback_ID`, `Product_Rating`, `Feedback_Description`, `Date`, `Cust_ID`, `Model_Number`) VALUES (61, 2, 'neque sed sem egestas blandit. Nam nulla magna, malesuada vel, convallis in, cursus et, eros.', '2014-05-01', 50, 7789261);
INSERT INTO `Delivery_System`.`Feedback` (`Feedback_ID`, `Product_Rating`, `Feedback_Description`, `Date`, `Cust_ID`, `Model_Number`) VALUES (62, 3, 'Quisque porttitor eros nec tellus. Nunc lectus pede, ultrices a, auctor non, feugiat nec, diam.', '2014-05-11', 73, 7789262);
INSERT INTO `Delivery_System`.`Feedback` (`Feedback_ID`, `Product_Rating`, `Feedback_Description`, `Date`, `Cust_ID`, `Model_Number`) VALUES (63, 5, 'Sed eu nibh vulputate mauris sagittis placerat. Cras dictum ultricies ligula. Nullam enim. Sed nulla', '2014-05-24', 41, 7789263);
INSERT INTO `Delivery_System`.`Feedback` (`Feedback_ID`, `Product_Rating`, `Feedback_Description`, `Date`, `Cust_ID`, `Model_Number`) VALUES (64, 5, 'ornare, lectus ante dictum mi, ac mattis velit justo nec ante. Maecenas mi felis, adipiscing', '2014-05-31', 62, 7789264);
INSERT INTO `Delivery_System`.`Feedback` (`Feedback_ID`, `Product_Rating`, `Feedback_Description`, `Date`, `Cust_ID`, `Model_Number`) VALUES (65, 1, 'et magnis dis parturient montes, nascetur ridiculus mus. Aenean eget magna. Suspendisse tristique neque venenatis', '2014-07-02', 23, 7789298);
INSERT INTO `Delivery_System`.`Feedback` (`Feedback_ID`, `Product_Rating`, `Feedback_Description`, `Date`, `Cust_ID`, `Model_Number`) VALUES (66, 1, 'magna. Cras convallis convallis dolor. Quisque tincidunt pede ac urna. Ut tincidunt vehicula risus. Nulla', '2014-07-09', 29, 7789266);
INSERT INTO `Delivery_System`.`Feedback` (`Feedback_ID`, `Product_Rating`, `Feedback_Description`, `Date`, `Cust_ID`, `Model_Number`) VALUES (67, 4, 'pretium neque. Morbi quis urna. Nunc quis arcu vel quam dignissim pharetra. Nam ac nulla.', '2014-07-17', 76, 7789267);
INSERT INTO `Delivery_System`.`Feedback` (`Feedback_ID`, `Product_Rating`, `Feedback_Description`, `Date`, `Cust_ID`, `Model_Number`) VALUES (68, 4, 'sit amet orci. Ut sagittis lobortis mauris. Suspendisse aliquet molestie tellus. Aenean egestas hendrerit neque.', '2014-07-29', 89, 7789268);
INSERT INTO `Delivery_System`.`Feedback` (`Feedback_ID`, `Product_Rating`, `Feedback_Description`, `Date`, `Cust_ID`, `Model_Number`) VALUES (69, 1, 'pede nec ante blandit viverra. Donec tempus, lorem fringilla ornare placerat, orci lacus vestibulum lorem,', '2014-08-18', 12, 7789269);
INSERT INTO `Delivery_System`.`Feedback` (`Feedback_ID`, `Product_Rating`, `Feedback_Description`, `Date`, `Cust_ID`, `Model_Number`) VALUES (70, 3, 'elementum at, egestas a, scelerisque sed, sapien. Nunc pulvinar arcu et pede. Nunc sed orci', '2014-08-19', 19, 7789270);
INSERT INTO `Delivery_System`.`Feedback` (`Feedback_ID`, `Product_Rating`, `Feedback_Description`, `Date`, `Cust_ID`, `Model_Number`) VALUES (71, 5, 'Morbi sit amet massa. Quisque porttitor eros nec tellus. Nunc lectus pede, ultrices a, auctor', '2014-08-22', 40, 7789271);
INSERT INTO `Delivery_System`.`Feedback` (`Feedback_ID`, `Product_Rating`, `Feedback_Description`, `Date`, `Cust_ID`, `Model_Number`) VALUES (72, 5, 'ac mattis semper, dui lectus rutrum urna, nec luctus felis purus ac tellus. Suspendisse sed', '2014-08-30', 80, 7789272);
INSERT INTO `Delivery_System`.`Feedback` (`Feedback_ID`, `Product_Rating`, `Feedback_Description`, `Date`, `Cust_ID`, `Model_Number`) VALUES (73, 2, 'non dui nec urna suscipit nonummy. Fusce fermentum fermentum arcu. Vestibulum ante ipsum primis in', '2014-09-06', 34, 7789273);
INSERT INTO `Delivery_System`.`Feedback` (`Feedback_ID`, `Product_Rating`, `Feedback_Description`, `Date`, `Cust_ID`, `Model_Number`) VALUES (74, 5, 'tempor erat neque non quam. Pellentesque habitant morbi tristique senectus et netus et malesuada fames', '2014-09-07', 9, 7789274);
INSERT INTO `Delivery_System`.`Feedback` (`Feedback_ID`, `Product_Rating`, `Feedback_Description`, `Date`, `Cust_ID`, `Model_Number`) VALUES (75, 3, 'molestie dapibus ligula. Aliquam erat volutpat. Nulla dignissim. Maecenas ornare egestas ligula. Nullam feugiat placerat', '2014-09-13', 10, 7789275);
INSERT INTO `Delivery_System`.`Feedback` (`Feedback_ID`, `Product_Rating`, `Feedback_Description`, `Date`, `Cust_ID`, `Model_Number`) VALUES (76, 2, 'risus odio, auctor vitae, aliquet nec, imperdiet nec, leo. Morbi neque tellus, imperdiet non, vestibulum', '2014-09-19', 89, 7789276);
INSERT INTO `Delivery_System`.`Feedback` (`Feedback_ID`, `Product_Rating`, `Feedback_Description`, `Date`, `Cust_ID`, `Model_Number`) VALUES (77, 1, 'nunc id enim. Curabitur massa. Vestibulum accumsan neque et nunc. Quisque ornare tortor at risus.', '2014-10-04', 15, 7789277);
INSERT INTO `Delivery_System`.`Feedback` (`Feedback_ID`, `Product_Rating`, `Feedback_Description`, `Date`, `Cust_ID`, `Model_Number`) VALUES (78, 5, 'enim, sit amet ornare lectus justo eu arcu. Morbi sit amet massa. Quisque porttitor eros', '2014-10-09', 4, 7789278);
INSERT INTO `Delivery_System`.`Feedback` (`Feedback_ID`, `Product_Rating`, `Feedback_Description`, `Date`, `Cust_ID`, `Model_Number`) VALUES (79, 1, 'volutpat nunc sit amet metus. Aliquam erat volutpat. Nulla facilisis. Suspendisse commodo tincidunt nibh. Phasellus', '2014-10-17', 89, 7789281);
INSERT INTO `Delivery_System`.`Feedback` (`Feedback_ID`, `Product_Rating`, `Feedback_Description`, `Date`, `Cust_ID`, `Model_Number`) VALUES (80, 2, 'est tempor bibendum. Donec felis orci, adipiscing non, luctus sit amet, faucibus ut, nulla. Cras', '2014-10-22', 46, 7789280);
INSERT INTO `Delivery_System`.`Feedback` (`Feedback_ID`, `Product_Rating`, `Feedback_Description`, `Date`, `Cust_ID`, `Model_Number`) VALUES (81, 4, 'rhoncus id, mollis nec, cursus a, enim. Suspendisse aliquet, sem ut cursus luctus, ipsum leo', '2014-10-30', 8, 7789281);
INSERT INTO `Delivery_System`.`Feedback` (`Feedback_ID`, `Product_Rating`, `Feedback_Description`, `Date`, `Cust_ID`, `Model_Number`) VALUES (82, 5, 'in consequat enim diam vel arcu. Curabitur ut odio vel est tempor bibendum. Donec felis', '2014-11-07', 5, 7789204);
INSERT INTO `Delivery_System`.`Feedback` (`Feedback_ID`, `Product_Rating`, `Feedback_Description`, `Date`, `Cust_ID`, `Model_Number`) VALUES (83, 4, 'nunc sit amet metus. Aliquam erat volutpat. Nulla facilisis. Suspendisse commodo tincidunt nibh. Phasellus nulla.', '2014-11-15', 78, 7789298);
INSERT INTO `Delivery_System`.`Feedback` (`Feedback_ID`, `Product_Rating`, `Feedback_Description`, `Date`, `Cust_ID`, `Model_Number`) VALUES (84, 4, 'neque venenatis lacus. Etiam bibendum fermentum metus. Aenean sed pede nec ante blandit viverra. Donec', '2014-12-28', 56, 7789284);
INSERT INTO `Delivery_System`.`Feedback` (`Feedback_ID`, `Product_Rating`, `Feedback_Description`, `Date`, `Cust_ID`, `Model_Number`) VALUES (85, 5, 'tellus justo sit amet nulla. Donec non justo. Proin non massa non ante bibendum ullamcorper.', '2015-01-06', 49, 7789285);
INSERT INTO `Delivery_System`.`Feedback` (`Feedback_ID`, `Product_Rating`, `Feedback_Description`, `Date`, `Cust_ID`, `Model_Number`) VALUES (86, 2, 'tempus eu, ligula. Aenean euismod mauris eu elit. Nulla facilisi. Sed neque. Sed eget lacus.', '2015-01-14', 15, 7789286);
INSERT INTO `Delivery_System`.`Feedback` (`Feedback_ID`, `Product_Rating`, `Feedback_Description`, `Date`, `Cust_ID`, `Model_Number`) VALUES (87, 5, 'In mi pede, nonummy ut, molestie in, tempus eu, ligula. Aenean euismod mauris eu elit.', '2015-01-16', 48, 7789287);
INSERT INTO `Delivery_System`.`Feedback` (`Feedback_ID`, `Product_Rating`, `Feedback_Description`, `Date`, `Cust_ID`, `Model_Number`) VALUES (88, 4, 'Aenean massa. Integer vitae nibh. Donec est mauris, rhoncus id, mollis nec, cursus a, enim.', '2015-01-24', 45, 7789245);
INSERT INTO `Delivery_System`.`Feedback` (`Feedback_ID`, `Product_Rating`, `Feedback_Description`, `Date`, `Cust_ID`, `Model_Number`) VALUES (89, 1, 'aliquet. Proin velit. Sed malesuada augue ut lacus. Nulla tincidunt, neque vitae semper egestas, urna', '2015-01-25', 46, 7789245);
INSERT INTO `Delivery_System`.`Feedback` (`Feedback_ID`, `Product_Rating`, `Feedback_Description`, `Date`, `Cust_ID`, `Model_Number`) VALUES (90, 2, 'risus. In mi pede, nonummy ut, molestie in, tempus eu, ligula. Aenean euismod mauris eu', '2015-02-20', 21, 7789290);
INSERT INTO `Delivery_System`.`Feedback` (`Feedback_ID`, `Product_Rating`, `Feedback_Description`, `Date`, `Cust_ID`, `Model_Number`) VALUES (91, 2, 'neque et nunc. Quisque ornare tortor at risus. Nunc ac sem ut dolor dapibus gravida.', '2015-02-20', 12, 7789204);
INSERT INTO `Delivery_System`.`Feedback` (`Feedback_ID`, `Product_Rating`, `Feedback_Description`, `Date`, `Cust_ID`, `Model_Number`) VALUES (92, 1, 'semper tellus id nunc interdum feugiat. Sed nec metus facilisis lorem tristique aliquet. Phasellus fermentum', '2015-03-03', 94, 7789292);
INSERT INTO `Delivery_System`.`Feedback` (`Feedback_ID`, `Product_Rating`, `Feedback_Description`, `Date`, `Cust_ID`, `Model_Number`) VALUES (93, 2, 'dictum. Phasellus in felis. Nulla tempor augue ac ipsum. Phasellus vitae mauris sit amet lorem', '2015-03-06', 76, 7789293);
INSERT INTO `Delivery_System`.`Feedback` (`Feedback_ID`, `Product_Rating`, `Feedback_Description`, `Date`, `Cust_ID`, `Model_Number`) VALUES (94, 1, 'primis in faucibus orci luctus et ultrices posuere cubilia Curae; Phasellus ornare. Fusce mollis. Duis', '2015-03-10', 89, 7789276);
INSERT INTO `Delivery_System`.`Feedback` (`Feedback_ID`, `Product_Rating`, `Feedback_Description`, `Date`, `Cust_ID`, `Model_Number`) VALUES (95, 5, 'Mauris ut quam vel sapien imperdiet ornare. In faucibus. Morbi vehicula. Pellentesque tincidunt tempus risus.', '2015-03-11', 12, 7789295);
INSERT INTO `Delivery_System`.`Feedback` (`Feedback_ID`, `Product_Rating`, `Feedback_Description`, `Date`, `Cust_ID`, `Model_Number`) VALUES (96, 4, 'Quisque libero lacus, varius et, euismod et, commodo at, libero. Morbi accumsan laoreet ipsum. Curabitur', '2015-03-20', 19, 7789296);
INSERT INTO `Delivery_System`.`Feedback` (`Feedback_ID`, `Product_Rating`, `Feedback_Description`, `Date`, `Cust_ID`, `Model_Number`) VALUES (97, 2, 'convallis convallis dolor. Quisque tincidunt pede ac urna. Ut tincidunt vehicula risus. Nulla eget metus', '2015-03-21', 40, 7789276);
INSERT INTO `Delivery_System`.`Feedback` (`Feedback_ID`, `Product_Rating`, `Feedback_Description`, `Date`, `Cust_ID`, `Model_Number`) VALUES (98, 5, 'consequat auctor, nunc nulla vulputate dui, nec tempus mauris erat eget ipsum. Suspendisse sagittis. Nullam', '2015-03-22', 80, 7789298);
INSERT INTO `Delivery_System`.`Feedback` (`Feedback_ID`, `Product_Rating`, `Feedback_Description`, `Date`, `Cust_ID`, `Model_Number`) VALUES (99, 3, 'egestas nunc sed libero. Proin sed turpis nec mauris blandit mattis. Cras eget nisi dictum', '2015-04-25', 100, 7789299);
INSERT INTO `Delivery_System`.`Feedback` (`Feedback_ID`, `Product_Rating`, `Feedback_Description`, `Date`, `Cust_ID`, `Model_Number`) VALUES (100, 2, 'lobortis augue scelerisque mollis. Phasellus libero mauris, aliquam eu, accumsan sed, facilisis vitae, orci. Phasellus', '2015-04-25', 45, 7789245);

COMMIT;


-- -----------------------------------------------------
-- Data for table `Delivery_System`.`Customer_has_CustShipping_Address`
-- -----------------------------------------------------
START TRANSACTION;
USE `Delivery_System`;
INSERT INTO `Delivery_System`.`Customer_has_CustShipping_Address` (`Cust_ID`, `ShippingAddress_ID`) VALUES (1, 15501);
INSERT INTO `Delivery_System`.`Customer_has_CustShipping_Address` (`Cust_ID`, `ShippingAddress_ID`) VALUES (2, 15502);
INSERT INTO `Delivery_System`.`Customer_has_CustShipping_Address` (`Cust_ID`, `ShippingAddress_ID`) VALUES (3, 15503);
INSERT INTO `Delivery_System`.`Customer_has_CustShipping_Address` (`Cust_ID`, `ShippingAddress_ID`) VALUES (4, 15504);
INSERT INTO `Delivery_System`.`Customer_has_CustShipping_Address` (`Cust_ID`, `ShippingAddress_ID`) VALUES (5, 15505);
INSERT INTO `Delivery_System`.`Customer_has_CustShipping_Address` (`Cust_ID`, `ShippingAddress_ID`) VALUES (6, 15506);
INSERT INTO `Delivery_System`.`Customer_has_CustShipping_Address` (`Cust_ID`, `ShippingAddress_ID`) VALUES (7, 15507);
INSERT INTO `Delivery_System`.`Customer_has_CustShipping_Address` (`Cust_ID`, `ShippingAddress_ID`) VALUES (8, 15508);
INSERT INTO `Delivery_System`.`Customer_has_CustShipping_Address` (`Cust_ID`, `ShippingAddress_ID`) VALUES (9, 15509);
INSERT INTO `Delivery_System`.`Customer_has_CustShipping_Address` (`Cust_ID`, `ShippingAddress_ID`) VALUES (10, 15510);
INSERT INTO `Delivery_System`.`Customer_has_CustShipping_Address` (`Cust_ID`, `ShippingAddress_ID`) VALUES (11, 15511);
INSERT INTO `Delivery_System`.`Customer_has_CustShipping_Address` (`Cust_ID`, `ShippingAddress_ID`) VALUES (12, 15512);
INSERT INTO `Delivery_System`.`Customer_has_CustShipping_Address` (`Cust_ID`, `ShippingAddress_ID`) VALUES (13, 15513);
INSERT INTO `Delivery_System`.`Customer_has_CustShipping_Address` (`Cust_ID`, `ShippingAddress_ID`) VALUES (14, 15514);
INSERT INTO `Delivery_System`.`Customer_has_CustShipping_Address` (`Cust_ID`, `ShippingAddress_ID`) VALUES (15, 15515);
INSERT INTO `Delivery_System`.`Customer_has_CustShipping_Address` (`Cust_ID`, `ShippingAddress_ID`) VALUES (16, 15516);
INSERT INTO `Delivery_System`.`Customer_has_CustShipping_Address` (`Cust_ID`, `ShippingAddress_ID`) VALUES (17, 15517);
INSERT INTO `Delivery_System`.`Customer_has_CustShipping_Address` (`Cust_ID`, `ShippingAddress_ID`) VALUES (18, 15518);
INSERT INTO `Delivery_System`.`Customer_has_CustShipping_Address` (`Cust_ID`, `ShippingAddress_ID`) VALUES (19, 15519);
INSERT INTO `Delivery_System`.`Customer_has_CustShipping_Address` (`Cust_ID`, `ShippingAddress_ID`) VALUES (20, 15520);
INSERT INTO `Delivery_System`.`Customer_has_CustShipping_Address` (`Cust_ID`, `ShippingAddress_ID`) VALUES (21, 15521);
INSERT INTO `Delivery_System`.`Customer_has_CustShipping_Address` (`Cust_ID`, `ShippingAddress_ID`) VALUES (22, 15522);
INSERT INTO `Delivery_System`.`Customer_has_CustShipping_Address` (`Cust_ID`, `ShippingAddress_ID`) VALUES (23, 15523);
INSERT INTO `Delivery_System`.`Customer_has_CustShipping_Address` (`Cust_ID`, `ShippingAddress_ID`) VALUES (24, 15524);
INSERT INTO `Delivery_System`.`Customer_has_CustShipping_Address` (`Cust_ID`, `ShippingAddress_ID`) VALUES (25, 15525);
INSERT INTO `Delivery_System`.`Customer_has_CustShipping_Address` (`Cust_ID`, `ShippingAddress_ID`) VALUES (26, 15526);
INSERT INTO `Delivery_System`.`Customer_has_CustShipping_Address` (`Cust_ID`, `ShippingAddress_ID`) VALUES (27, 15527);
INSERT INTO `Delivery_System`.`Customer_has_CustShipping_Address` (`Cust_ID`, `ShippingAddress_ID`) VALUES (28, 15528);
INSERT INTO `Delivery_System`.`Customer_has_CustShipping_Address` (`Cust_ID`, `ShippingAddress_ID`) VALUES (29, 15529);
INSERT INTO `Delivery_System`.`Customer_has_CustShipping_Address` (`Cust_ID`, `ShippingAddress_ID`) VALUES (30, 15530);
INSERT INTO `Delivery_System`.`Customer_has_CustShipping_Address` (`Cust_ID`, `ShippingAddress_ID`) VALUES (31, 15531);
INSERT INTO `Delivery_System`.`Customer_has_CustShipping_Address` (`Cust_ID`, `ShippingAddress_ID`) VALUES (32, 15532);
INSERT INTO `Delivery_System`.`Customer_has_CustShipping_Address` (`Cust_ID`, `ShippingAddress_ID`) VALUES (33, 15533);
INSERT INTO `Delivery_System`.`Customer_has_CustShipping_Address` (`Cust_ID`, `ShippingAddress_ID`) VALUES (34, 15534);
INSERT INTO `Delivery_System`.`Customer_has_CustShipping_Address` (`Cust_ID`, `ShippingAddress_ID`) VALUES (35, 15535);
INSERT INTO `Delivery_System`.`Customer_has_CustShipping_Address` (`Cust_ID`, `ShippingAddress_ID`) VALUES (36, 15536);
INSERT INTO `Delivery_System`.`Customer_has_CustShipping_Address` (`Cust_ID`, `ShippingAddress_ID`) VALUES (37, 15537);
INSERT INTO `Delivery_System`.`Customer_has_CustShipping_Address` (`Cust_ID`, `ShippingAddress_ID`) VALUES (38, 15538);
INSERT INTO `Delivery_System`.`Customer_has_CustShipping_Address` (`Cust_ID`, `ShippingAddress_ID`) VALUES (39, 15539);
INSERT INTO `Delivery_System`.`Customer_has_CustShipping_Address` (`Cust_ID`, `ShippingAddress_ID`) VALUES (40, 15540);
INSERT INTO `Delivery_System`.`Customer_has_CustShipping_Address` (`Cust_ID`, `ShippingAddress_ID`) VALUES (41, 15541);
INSERT INTO `Delivery_System`.`Customer_has_CustShipping_Address` (`Cust_ID`, `ShippingAddress_ID`) VALUES (42, 15542);
INSERT INTO `Delivery_System`.`Customer_has_CustShipping_Address` (`Cust_ID`, `ShippingAddress_ID`) VALUES (43, 15543);
INSERT INTO `Delivery_System`.`Customer_has_CustShipping_Address` (`Cust_ID`, `ShippingAddress_ID`) VALUES (44, 15544);
INSERT INTO `Delivery_System`.`Customer_has_CustShipping_Address` (`Cust_ID`, `ShippingAddress_ID`) VALUES (45, 15545);
INSERT INTO `Delivery_System`.`Customer_has_CustShipping_Address` (`Cust_ID`, `ShippingAddress_ID`) VALUES (46, 15546);
INSERT INTO `Delivery_System`.`Customer_has_CustShipping_Address` (`Cust_ID`, `ShippingAddress_ID`) VALUES (47, 15547);
INSERT INTO `Delivery_System`.`Customer_has_CustShipping_Address` (`Cust_ID`, `ShippingAddress_ID`) VALUES (48, 15548);
INSERT INTO `Delivery_System`.`Customer_has_CustShipping_Address` (`Cust_ID`, `ShippingAddress_ID`) VALUES (49, 15549);
INSERT INTO `Delivery_System`.`Customer_has_CustShipping_Address` (`Cust_ID`, `ShippingAddress_ID`) VALUES (50, 15550);
INSERT INTO `Delivery_System`.`Customer_has_CustShipping_Address` (`Cust_ID`, `ShippingAddress_ID`) VALUES (51, 15551);
INSERT INTO `Delivery_System`.`Customer_has_CustShipping_Address` (`Cust_ID`, `ShippingAddress_ID`) VALUES (52, 15552);
INSERT INTO `Delivery_System`.`Customer_has_CustShipping_Address` (`Cust_ID`, `ShippingAddress_ID`) VALUES (53, 15553);
INSERT INTO `Delivery_System`.`Customer_has_CustShipping_Address` (`Cust_ID`, `ShippingAddress_ID`) VALUES (54, 15554);
INSERT INTO `Delivery_System`.`Customer_has_CustShipping_Address` (`Cust_ID`, `ShippingAddress_ID`) VALUES (55, 15555);
INSERT INTO `Delivery_System`.`Customer_has_CustShipping_Address` (`Cust_ID`, `ShippingAddress_ID`) VALUES (56, 15556);
INSERT INTO `Delivery_System`.`Customer_has_CustShipping_Address` (`Cust_ID`, `ShippingAddress_ID`) VALUES (57, 15557);
INSERT INTO `Delivery_System`.`Customer_has_CustShipping_Address` (`Cust_ID`, `ShippingAddress_ID`) VALUES (58, 15558);
INSERT INTO `Delivery_System`.`Customer_has_CustShipping_Address` (`Cust_ID`, `ShippingAddress_ID`) VALUES (59, 15559);
INSERT INTO `Delivery_System`.`Customer_has_CustShipping_Address` (`Cust_ID`, `ShippingAddress_ID`) VALUES (60, 15560);
INSERT INTO `Delivery_System`.`Customer_has_CustShipping_Address` (`Cust_ID`, `ShippingAddress_ID`) VALUES (61, 15561);
INSERT INTO `Delivery_System`.`Customer_has_CustShipping_Address` (`Cust_ID`, `ShippingAddress_ID`) VALUES (62, 15562);
INSERT INTO `Delivery_System`.`Customer_has_CustShipping_Address` (`Cust_ID`, `ShippingAddress_ID`) VALUES (63, 15563);
INSERT INTO `Delivery_System`.`Customer_has_CustShipping_Address` (`Cust_ID`, `ShippingAddress_ID`) VALUES (64, 15564);
INSERT INTO `Delivery_System`.`Customer_has_CustShipping_Address` (`Cust_ID`, `ShippingAddress_ID`) VALUES (65, 15565);
INSERT INTO `Delivery_System`.`Customer_has_CustShipping_Address` (`Cust_ID`, `ShippingAddress_ID`) VALUES (66, 15566);
INSERT INTO `Delivery_System`.`Customer_has_CustShipping_Address` (`Cust_ID`, `ShippingAddress_ID`) VALUES (67, 15567);
INSERT INTO `Delivery_System`.`Customer_has_CustShipping_Address` (`Cust_ID`, `ShippingAddress_ID`) VALUES (68, 15568);
INSERT INTO `Delivery_System`.`Customer_has_CustShipping_Address` (`Cust_ID`, `ShippingAddress_ID`) VALUES (69, 15569);
INSERT INTO `Delivery_System`.`Customer_has_CustShipping_Address` (`Cust_ID`, `ShippingAddress_ID`) VALUES (70, 15570);
INSERT INTO `Delivery_System`.`Customer_has_CustShipping_Address` (`Cust_ID`, `ShippingAddress_ID`) VALUES (71, 15571);
INSERT INTO `Delivery_System`.`Customer_has_CustShipping_Address` (`Cust_ID`, `ShippingAddress_ID`) VALUES (72, 15572);
INSERT INTO `Delivery_System`.`Customer_has_CustShipping_Address` (`Cust_ID`, `ShippingAddress_ID`) VALUES (73, 15573);
INSERT INTO `Delivery_System`.`Customer_has_CustShipping_Address` (`Cust_ID`, `ShippingAddress_ID`) VALUES (74, 15574);
INSERT INTO `Delivery_System`.`Customer_has_CustShipping_Address` (`Cust_ID`, `ShippingAddress_ID`) VALUES (75, 15575);
INSERT INTO `Delivery_System`.`Customer_has_CustShipping_Address` (`Cust_ID`, `ShippingAddress_ID`) VALUES (76, 15576);
INSERT INTO `Delivery_System`.`Customer_has_CustShipping_Address` (`Cust_ID`, `ShippingAddress_ID`) VALUES (77, 15577);
INSERT INTO `Delivery_System`.`Customer_has_CustShipping_Address` (`Cust_ID`, `ShippingAddress_ID`) VALUES (78, 15578);
INSERT INTO `Delivery_System`.`Customer_has_CustShipping_Address` (`Cust_ID`, `ShippingAddress_ID`) VALUES (79, 15579);
INSERT INTO `Delivery_System`.`Customer_has_CustShipping_Address` (`Cust_ID`, `ShippingAddress_ID`) VALUES (80, 15580);
INSERT INTO `Delivery_System`.`Customer_has_CustShipping_Address` (`Cust_ID`, `ShippingAddress_ID`) VALUES (81, 15581);
INSERT INTO `Delivery_System`.`Customer_has_CustShipping_Address` (`Cust_ID`, `ShippingAddress_ID`) VALUES (82, 15582);
INSERT INTO `Delivery_System`.`Customer_has_CustShipping_Address` (`Cust_ID`, `ShippingAddress_ID`) VALUES (83, 15583);
INSERT INTO `Delivery_System`.`Customer_has_CustShipping_Address` (`Cust_ID`, `ShippingAddress_ID`) VALUES (84, 15584);
INSERT INTO `Delivery_System`.`Customer_has_CustShipping_Address` (`Cust_ID`, `ShippingAddress_ID`) VALUES (85, 15585);
INSERT INTO `Delivery_System`.`Customer_has_CustShipping_Address` (`Cust_ID`, `ShippingAddress_ID`) VALUES (86, 15586);
INSERT INTO `Delivery_System`.`Customer_has_CustShipping_Address` (`Cust_ID`, `ShippingAddress_ID`) VALUES (87, 15587);
INSERT INTO `Delivery_System`.`Customer_has_CustShipping_Address` (`Cust_ID`, `ShippingAddress_ID`) VALUES (88, 15588);
INSERT INTO `Delivery_System`.`Customer_has_CustShipping_Address` (`Cust_ID`, `ShippingAddress_ID`) VALUES (89, 15589);
INSERT INTO `Delivery_System`.`Customer_has_CustShipping_Address` (`Cust_ID`, `ShippingAddress_ID`) VALUES (90, 15590);
INSERT INTO `Delivery_System`.`Customer_has_CustShipping_Address` (`Cust_ID`, `ShippingAddress_ID`) VALUES (91, 15591);
INSERT INTO `Delivery_System`.`Customer_has_CustShipping_Address` (`Cust_ID`, `ShippingAddress_ID`) VALUES (92, 15592);
INSERT INTO `Delivery_System`.`Customer_has_CustShipping_Address` (`Cust_ID`, `ShippingAddress_ID`) VALUES (93, 15593);
INSERT INTO `Delivery_System`.`Customer_has_CustShipping_Address` (`Cust_ID`, `ShippingAddress_ID`) VALUES (94, 15594);
INSERT INTO `Delivery_System`.`Customer_has_CustShipping_Address` (`Cust_ID`, `ShippingAddress_ID`) VALUES (95, 15595);
INSERT INTO `Delivery_System`.`Customer_has_CustShipping_Address` (`Cust_ID`, `ShippingAddress_ID`) VALUES (96, 15596);
INSERT INTO `Delivery_System`.`Customer_has_CustShipping_Address` (`Cust_ID`, `ShippingAddress_ID`) VALUES (97, 15597);
INSERT INTO `Delivery_System`.`Customer_has_CustShipping_Address` (`Cust_ID`, `ShippingAddress_ID`) VALUES (98, 15598);
INSERT INTO `Delivery_System`.`Customer_has_CustShipping_Address` (`Cust_ID`, `ShippingAddress_ID`) VALUES (99, 15599);
INSERT INTO `Delivery_System`.`Customer_has_CustShipping_Address` (`Cust_ID`, `ShippingAddress_ID`) VALUES (100, 15600);

COMMIT;


-- -----------------------------------------------------
-- Data for table `Delivery_System`.`Drone_Delivery`
-- -----------------------------------------------------
START TRANSACTION;
USE `Delivery_System`;
INSERT INTO `Delivery_System`.`Drone_Delivery` (`Delivery_ID`, `Delivery_Date`, `Delivery_Time`, `Drone_ID`, `ShippingAddress_ID`, `OrderItem_ID`) VALUES (1, '2015-04-26', '06:30:00', 11, 15510, 100191);
INSERT INTO `Delivery_System`.`Drone_Delivery` (`Delivery_ID`, `Delivery_Date`, `Delivery_Time`, `Drone_ID`, `ShippingAddress_ID`, `OrderItem_ID`) VALUES (2, '2015-04-26', '07:30:00', 56, 15557, 100192);
INSERT INTO `Delivery_System`.`Drone_Delivery` (`Delivery_ID`, `Delivery_Date`, `Delivery_Time`, `Drone_ID`, `ShippingAddress_ID`, `OrderItem_ID`) VALUES (3, '2015-04-26', '08:30:00', 89, 15544, 100193);
INSERT INTO `Delivery_System`.`Drone_Delivery` (`Delivery_ID`, `Delivery_Date`, `Delivery_Time`, `Drone_ID`, `ShippingAddress_ID`, `OrderItem_ID`) VALUES (4, '2015-04-26', '09:30:00', 112, 15569, 100194);
INSERT INTO `Delivery_System`.`Drone_Delivery` (`Delivery_ID`, `Delivery_Date`, `Delivery_Time`, `Drone_ID`, `ShippingAddress_ID`, `OrderItem_ID`) VALUES (5, '2015-04-26', '10:30:00', 78, 15547, 100195);
INSERT INTO `Delivery_System`.`Drone_Delivery` (`Delivery_ID`, `Delivery_Date`, `Delivery_Time`, `Drone_ID`, `ShippingAddress_ID`, `OrderItem_ID`) VALUES (6, '2015-04-26', '11:30:00', 163, 15518, 100196);
INSERT INTO `Delivery_System`.`Drone_Delivery` (`Delivery_ID`, `Delivery_Date`, `Delivery_Time`, `Drone_ID`, `ShippingAddress_ID`, `OrderItem_ID`) VALUES (7, '2015-04-26', '12:30:00', 146, 15516, 100197);
INSERT INTO `Delivery_System`.`Drone_Delivery` (`Delivery_ID`, `Delivery_Date`, `Delivery_Time`, `Drone_ID`, `ShippingAddress_ID`, `OrderItem_ID`) VALUES (8, '2015-04-26', '13:30:00', 236, 15530, 100198);
INSERT INTO `Delivery_System`.`Drone_Delivery` (`Delivery_ID`, `Delivery_Date`, `Delivery_Time`, `Drone_ID`, `ShippingAddress_ID`, `OrderItem_ID`) VALUES (9, '2015-04-26', '14:30:00', 271, 15564, 100199);
INSERT INTO `Delivery_System`.`Drone_Delivery` (`Delivery_ID`, `Delivery_Date`, `Delivery_Time`, `Drone_ID`, `ShippingAddress_ID`, `OrderItem_ID`) VALUES (10, '2015-04-26', '15:30:00', 311, 15591, 100200);

COMMIT;


-- -----------------------------------------------------
-- Data for table `Delivery_System`.`Warehouse_has_Product_Model`
-- -----------------------------------------------------
START TRANSACTION;
USE `Delivery_System`;
INSERT INTO `Delivery_System`.`Warehouse_has_Product_Model` (`warehouse_ID`, `Model_Number`) VALUES (6, 7789201);
INSERT INTO `Delivery_System`.`Warehouse_has_Product_Model` (`warehouse_ID`, `Model_Number`) VALUES (1, 7789202);
INSERT INTO `Delivery_System`.`Warehouse_has_Product_Model` (`warehouse_ID`, `Model_Number`) VALUES (3, 7789203);
INSERT INTO `Delivery_System`.`Warehouse_has_Product_Model` (`warehouse_ID`, `Model_Number`) VALUES (17, 7789204);
INSERT INTO `Delivery_System`.`Warehouse_has_Product_Model` (`warehouse_ID`, `Model_Number`) VALUES (5, 7789205);
INSERT INTO `Delivery_System`.`Warehouse_has_Product_Model` (`warehouse_ID`, `Model_Number`) VALUES (3, 7789206);
INSERT INTO `Delivery_System`.`Warehouse_has_Product_Model` (`warehouse_ID`, `Model_Number`) VALUES (4, 7789207);
INSERT INTO `Delivery_System`.`Warehouse_has_Product_Model` (`warehouse_ID`, `Model_Number`) VALUES (15, 7789208);
INSERT INTO `Delivery_System`.`Warehouse_has_Product_Model` (`warehouse_ID`, `Model_Number`) VALUES (5, 7789209);
INSERT INTO `Delivery_System`.`Warehouse_has_Product_Model` (`warehouse_ID`, `Model_Number`) VALUES (4, 7789210);
INSERT INTO `Delivery_System`.`Warehouse_has_Product_Model` (`warehouse_ID`, `Model_Number`) VALUES (1, 7789211);
INSERT INTO `Delivery_System`.`Warehouse_has_Product_Model` (`warehouse_ID`, `Model_Number`) VALUES (31, 7789212);
INSERT INTO `Delivery_System`.`Warehouse_has_Product_Model` (`warehouse_ID`, `Model_Number`) VALUES (31, 7789213);
INSERT INTO `Delivery_System`.`Warehouse_has_Product_Model` (`warehouse_ID`, `Model_Number`) VALUES (5, 7789214);
INSERT INTO `Delivery_System`.`Warehouse_has_Product_Model` (`warehouse_ID`, `Model_Number`) VALUES (2, 7789215);
INSERT INTO `Delivery_System`.`Warehouse_has_Product_Model` (`warehouse_ID`, `Model_Number`) VALUES (21, 7789216);
INSERT INTO `Delivery_System`.`Warehouse_has_Product_Model` (`warehouse_ID`, `Model_Number`) VALUES (23, 7789217);
INSERT INTO `Delivery_System`.`Warehouse_has_Product_Model` (`warehouse_ID`, `Model_Number`) VALUES (24, 7789218);
INSERT INTO `Delivery_System`.`Warehouse_has_Product_Model` (`warehouse_ID`, `Model_Number`) VALUES (25, 7789219);
INSERT INTO `Delivery_System`.`Warehouse_has_Product_Model` (`warehouse_ID`, `Model_Number`) VALUES (11, 7789220);
INSERT INTO `Delivery_System`.`Warehouse_has_Product_Model` (`warehouse_ID`, `Model_Number`) VALUES (2, 7789221);
INSERT INTO `Delivery_System`.`Warehouse_has_Product_Model` (`warehouse_ID`, `Model_Number`) VALUES (18, 7789222);
INSERT INTO `Delivery_System`.`Warehouse_has_Product_Model` (`warehouse_ID`, `Model_Number`) VALUES (24, 7789223);
INSERT INTO `Delivery_System`.`Warehouse_has_Product_Model` (`warehouse_ID`, `Model_Number`) VALUES (11, 7789224);
INSERT INTO `Delivery_System`.`Warehouse_has_Product_Model` (`warehouse_ID`, `Model_Number`) VALUES (14, 7789225);
INSERT INTO `Delivery_System`.`Warehouse_has_Product_Model` (`warehouse_ID`, `Model_Number`) VALUES (28, 7789226);
INSERT INTO `Delivery_System`.`Warehouse_has_Product_Model` (`warehouse_ID`, `Model_Number`) VALUES (1, 7789227);
INSERT INTO `Delivery_System`.`Warehouse_has_Product_Model` (`warehouse_ID`, `Model_Number`) VALUES (19, 7789228);
INSERT INTO `Delivery_System`.`Warehouse_has_Product_Model` (`warehouse_ID`, `Model_Number`) VALUES (13, 7789229);
INSERT INTO `Delivery_System`.`Warehouse_has_Product_Model` (`warehouse_ID`, `Model_Number`) VALUES (12, 7789230);
INSERT INTO `Delivery_System`.`Warehouse_has_Product_Model` (`warehouse_ID`, `Model_Number`) VALUES (29, 7789231);
INSERT INTO `Delivery_System`.`Warehouse_has_Product_Model` (`warehouse_ID`, `Model_Number`) VALUES (23, 7789232);
INSERT INTO `Delivery_System`.`Warehouse_has_Product_Model` (`warehouse_ID`, `Model_Number`) VALUES (20, 7789233);
INSERT INTO `Delivery_System`.`Warehouse_has_Product_Model` (`warehouse_ID`, `Model_Number`) VALUES (4, 7789234);
INSERT INTO `Delivery_System`.`Warehouse_has_Product_Model` (`warehouse_ID`, `Model_Number`) VALUES (2, 7789235);
INSERT INTO `Delivery_System`.`Warehouse_has_Product_Model` (`warehouse_ID`, `Model_Number`) VALUES (23, 7789236);
INSERT INTO `Delivery_System`.`Warehouse_has_Product_Model` (`warehouse_ID`, `Model_Number`) VALUES (7, 7789237);
INSERT INTO `Delivery_System`.`Warehouse_has_Product_Model` (`warehouse_ID`, `Model_Number`) VALUES (28, 7789238);
INSERT INTO `Delivery_System`.`Warehouse_has_Product_Model` (`warehouse_ID`, `Model_Number`) VALUES (8, 7789239);
INSERT INTO `Delivery_System`.`Warehouse_has_Product_Model` (`warehouse_ID`, `Model_Number`) VALUES (24, 7789240);
INSERT INTO `Delivery_System`.`Warehouse_has_Product_Model` (`warehouse_ID`, `Model_Number`) VALUES (10, 7789241);
INSERT INTO `Delivery_System`.`Warehouse_has_Product_Model` (`warehouse_ID`, `Model_Number`) VALUES (19, 7789242);
INSERT INTO `Delivery_System`.`Warehouse_has_Product_Model` (`warehouse_ID`, `Model_Number`) VALUES (29, 7789243);
INSERT INTO `Delivery_System`.`Warehouse_has_Product_Model` (`warehouse_ID`, `Model_Number`) VALUES (8, 7789244);
INSERT INTO `Delivery_System`.`Warehouse_has_Product_Model` (`warehouse_ID`, `Model_Number`) VALUES (5, 7789245);
INSERT INTO `Delivery_System`.`Warehouse_has_Product_Model` (`warehouse_ID`, `Model_Number`) VALUES (28, 7789246);
INSERT INTO `Delivery_System`.`Warehouse_has_Product_Model` (`warehouse_ID`, `Model_Number`) VALUES (25, 7789247);
INSERT INTO `Delivery_System`.`Warehouse_has_Product_Model` (`warehouse_ID`, `Model_Number`) VALUES (16, 7789248);
INSERT INTO `Delivery_System`.`Warehouse_has_Product_Model` (`warehouse_ID`, `Model_Number`) VALUES (11, 7789249);
INSERT INTO `Delivery_System`.`Warehouse_has_Product_Model` (`warehouse_ID`, `Model_Number`) VALUES (20, 7789250);
INSERT INTO `Delivery_System`.`Warehouse_has_Product_Model` (`warehouse_ID`, `Model_Number`) VALUES (18, 7789251);
INSERT INTO `Delivery_System`.`Warehouse_has_Product_Model` (`warehouse_ID`, `Model_Number`) VALUES (2, 7789252);
INSERT INTO `Delivery_System`.`Warehouse_has_Product_Model` (`warehouse_ID`, `Model_Number`) VALUES (5, 7789253);
INSERT INTO `Delivery_System`.`Warehouse_has_Product_Model` (`warehouse_ID`, `Model_Number`) VALUES (26, 7789254);
INSERT INTO `Delivery_System`.`Warehouse_has_Product_Model` (`warehouse_ID`, `Model_Number`) VALUES (3, 7789255);
INSERT INTO `Delivery_System`.`Warehouse_has_Product_Model` (`warehouse_ID`, `Model_Number`) VALUES (3, 7789256);
INSERT INTO `Delivery_System`.`Warehouse_has_Product_Model` (`warehouse_ID`, `Model_Number`) VALUES (26, 7789257);
INSERT INTO `Delivery_System`.`Warehouse_has_Product_Model` (`warehouse_ID`, `Model_Number`) VALUES (2, 7789258);
INSERT INTO `Delivery_System`.`Warehouse_has_Product_Model` (`warehouse_ID`, `Model_Number`) VALUES (7, 7789259);
INSERT INTO `Delivery_System`.`Warehouse_has_Product_Model` (`warehouse_ID`, `Model_Number`) VALUES (15, 7789260);
INSERT INTO `Delivery_System`.`Warehouse_has_Product_Model` (`warehouse_ID`, `Model_Number`) VALUES (4, 7789261);
INSERT INTO `Delivery_System`.`Warehouse_has_Product_Model` (`warehouse_ID`, `Model_Number`) VALUES (22, 7789262);
INSERT INTO `Delivery_System`.`Warehouse_has_Product_Model` (`warehouse_ID`, `Model_Number`) VALUES (27, 7789263);
INSERT INTO `Delivery_System`.`Warehouse_has_Product_Model` (`warehouse_ID`, `Model_Number`) VALUES (15, 7789264);
INSERT INTO `Delivery_System`.`Warehouse_has_Product_Model` (`warehouse_ID`, `Model_Number`) VALUES (18, 7789265);
INSERT INTO `Delivery_System`.`Warehouse_has_Product_Model` (`warehouse_ID`, `Model_Number`) VALUES (4, 7789266);
INSERT INTO `Delivery_System`.`Warehouse_has_Product_Model` (`warehouse_ID`, `Model_Number`) VALUES (8, 7789267);
INSERT INTO `Delivery_System`.`Warehouse_has_Product_Model` (`warehouse_ID`, `Model_Number`) VALUES (26, 7789268);
INSERT INTO `Delivery_System`.`Warehouse_has_Product_Model` (`warehouse_ID`, `Model_Number`) VALUES (12, 7789269);
INSERT INTO `Delivery_System`.`Warehouse_has_Product_Model` (`warehouse_ID`, `Model_Number`) VALUES (21, 7789270);
INSERT INTO `Delivery_System`.`Warehouse_has_Product_Model` (`warehouse_ID`, `Model_Number`) VALUES (14, 7789271);
INSERT INTO `Delivery_System`.`Warehouse_has_Product_Model` (`warehouse_ID`, `Model_Number`) VALUES (29, 7789272);
INSERT INTO `Delivery_System`.`Warehouse_has_Product_Model` (`warehouse_ID`, `Model_Number`) VALUES (7, 7789273);
INSERT INTO `Delivery_System`.`Warehouse_has_Product_Model` (`warehouse_ID`, `Model_Number`) VALUES (30, 7789274);
INSERT INTO `Delivery_System`.`Warehouse_has_Product_Model` (`warehouse_ID`, `Model_Number`) VALUES (4, 7789275);
INSERT INTO `Delivery_System`.`Warehouse_has_Product_Model` (`warehouse_ID`, `Model_Number`) VALUES (27, 7789276);
INSERT INTO `Delivery_System`.`Warehouse_has_Product_Model` (`warehouse_ID`, `Model_Number`) VALUES (30, 7789277);
INSERT INTO `Delivery_System`.`Warehouse_has_Product_Model` (`warehouse_ID`, `Model_Number`) VALUES (19, 7789278);
INSERT INTO `Delivery_System`.`Warehouse_has_Product_Model` (`warehouse_ID`, `Model_Number`) VALUES (1, 7789279);
INSERT INTO `Delivery_System`.`Warehouse_has_Product_Model` (`warehouse_ID`, `Model_Number`) VALUES (14, 7789280);
INSERT INTO `Delivery_System`.`Warehouse_has_Product_Model` (`warehouse_ID`, `Model_Number`) VALUES (18, 7789281);
INSERT INTO `Delivery_System`.`Warehouse_has_Product_Model` (`warehouse_ID`, `Model_Number`) VALUES (10, 7789282);
INSERT INTO `Delivery_System`.`Warehouse_has_Product_Model` (`warehouse_ID`, `Model_Number`) VALUES (8, 7789283);
INSERT INTO `Delivery_System`.`Warehouse_has_Product_Model` (`warehouse_ID`, `Model_Number`) VALUES (23, 7789284);
INSERT INTO `Delivery_System`.`Warehouse_has_Product_Model` (`warehouse_ID`, `Model_Number`) VALUES (25, 7789285);
INSERT INTO `Delivery_System`.`Warehouse_has_Product_Model` (`warehouse_ID`, `Model_Number`) VALUES (29, 7789286);
INSERT INTO `Delivery_System`.`Warehouse_has_Product_Model` (`warehouse_ID`, `Model_Number`) VALUES (13, 7789287);
INSERT INTO `Delivery_System`.`Warehouse_has_Product_Model` (`warehouse_ID`, `Model_Number`) VALUES (11, 7789288);
INSERT INTO `Delivery_System`.`Warehouse_has_Product_Model` (`warehouse_ID`, `Model_Number`) VALUES (29, 7789289);
INSERT INTO `Delivery_System`.`Warehouse_has_Product_Model` (`warehouse_ID`, `Model_Number`) VALUES (12, 7789290);
INSERT INTO `Delivery_System`.`Warehouse_has_Product_Model` (`warehouse_ID`, `Model_Number`) VALUES (19, 7789291);
INSERT INTO `Delivery_System`.`Warehouse_has_Product_Model` (`warehouse_ID`, `Model_Number`) VALUES (25, 7789292);
INSERT INTO `Delivery_System`.`Warehouse_has_Product_Model` (`warehouse_ID`, `Model_Number`) VALUES (14, 7789293);
INSERT INTO `Delivery_System`.`Warehouse_has_Product_Model` (`warehouse_ID`, `Model_Number`) VALUES (24, 7789294);
INSERT INTO `Delivery_System`.`Warehouse_has_Product_Model` (`warehouse_ID`, `Model_Number`) VALUES (4, 7789295);
INSERT INTO `Delivery_System`.`Warehouse_has_Product_Model` (`warehouse_ID`, `Model_Number`) VALUES (19, 7789296);
INSERT INTO `Delivery_System`.`Warehouse_has_Product_Model` (`warehouse_ID`, `Model_Number`) VALUES (4, 7789297);
INSERT INTO `Delivery_System`.`Warehouse_has_Product_Model` (`warehouse_ID`, `Model_Number`) VALUES (5, 7789298);
INSERT INTO `Delivery_System`.`Warehouse_has_Product_Model` (`warehouse_ID`, `Model_Number`) VALUES (27, 7789299);
INSERT INTO `Delivery_System`.`Warehouse_has_Product_Model` (`warehouse_ID`, `Model_Number`) VALUES (26, 7789300);

COMMIT;

