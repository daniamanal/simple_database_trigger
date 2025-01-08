CREATE TABLE Guest_Checkout 
(Guest_ID INT, 
Booking_ID INT NOT NULL , 
Checkout_Date DATETIME NOT NULL, 
Paid_Amount DECIMAL(6,2) NOT NULL, 
Payment_Details VARCHAR (255) NULL,
PRIMARY KEY (Guest_ID, Booking_ID)
);

SELECT* FROM Guest_Checkout;
CREATE TABLE Guest 
(Guest_ID INT,
Guest_details VARCHAR (255),
PRIMARY KEY (Guest_ID)

);
CREATE TABLE Guest_Messages 
(Message_ID INT, 
Guest_ID INT, 
Message_Details VARCHAR (255) NULL,
PRIMARY KEY(Message_ID),
FOREIGN KEY(Guest_ID) REFERENCES Guest(Guest_ID)
);
SELECT* FROM Guest_Messages;
CREATE TRIGGER ThankYouEmail ON Guest_Checkout
AFTER INSERT 
AS
BEGIN
    -- Insert a thank-you message into Guest_Messages after a checkout
    INSERT INTO Guest_Messages (Guest_ID, Message_Details)
    SELECT Guest_ID, 'Thank You for staying with us. Please come back again soon!!'
    FROM inserted;
END;
CREATE PROCEDURE GetHotelDetails
    @Hotel_Name VARCHAR(255)
AS
BEGIN
    -- Select the required details
    SELECT 
        hc.Hotel_Chain_Name,
        c.Country_Name,
        hc.Star_Rating_Image,
        hc.Hotel_Characteristic_Details,
        ra.Room_Availability_Count
    FROM 
        Hotels h
    JOIN 
        Hotel_Chains hc ON h.Hotel_Chain_ID = hc.Hotel_Chain_ID
    JOIN 
        Countries c ON h.Country_ID = c.Country_ID
    JOIN 
        Hotel_Characteristics hc ON h.Hotel_ID = hc.Hotel_ID
    LEFT JOIN 
        Room_Availability ra ON h.Hotel_ID = ra.Hotel_ID
    WHERE 
        h.Hotel_Name = @Hotel_Name;
END;