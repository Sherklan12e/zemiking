USE movies;

DELIMITER $$

CREATE DEFINER=`root`@`localhost` PROCEDURE `movieAddOrEditWithImage`(
  IN `_id` INT,
  IN `_name` VARCHAR(150),
  IN `_year` INT,
  IN `_image_url` VARCHAR(255)
)
LANGUAGE SQL
NOT DETERMINISTIC
CONTAINS SQL
SQL SECURITY DEFINER
COMMENT 'Procedure to add or edit movies'
BEGIN
  IF _id = 0 THEN
    -- Insert new movie
    INSERT INTO movies (name, year, image_url)
    VALUES (_name, _year, _image_url);
    SET _id = LAST_INSERT_ID();
  ELSE
    -- Update existing movie
    UPDATE movies
    SET
      name = _name,
      year = _year,
      image_url = COALESCE(_image_url, image_url)
    WHERE id = _id;
  END IF;

  -- Return the ID of the inserted or updated movie
  SELECT _id AS 'id';
END$$

DELIMITER ;
