

-- Создаем таблицу с контейнерами

CREATE TABLE Containers (
    ContainerID UNIQUEIDENTIFIER PRIMARY KEY DEFAULT NEWID(),
    Number INT NOT NULL,
    Type NVARCHAR(50) NOT NULL,
    Length FLOAT NOT NULL,
    Width FLOAT NOT NULL,
    Height FLOAT NOT NULL,
    Weight FLOAT NOT NULL,
    IsEmpty BIT NOT NULL,
    ArrivalDate DATETIME NOT NULL
);



-- Создаем таблицу с оперторами

CREATE TABLE Operations (
    OperationID UNIQUEIDENTIFIER PRIMARY KEY DEFAULT NEWID(),
    ContainerID UNIQUEIDENTIFIER NOT NULL,
    StartDate DATETIME NOT NULL,
    EndDate DATETIME NOT NULL,
    OperationType NVARCHAR(50) NOT NULL,
    OperatorName NVARCHAR(100) NOT NULL,
    InspectionLocation NVARCHAR(100) NOT NULL
);


-- Превращение таблицы Containers в json формат

SELECT 
    '[' + STRING_AGG(
        '{"ContainerID": "' + CAST(ContainerID AS NVARCHAR(36)) + '", ' +
        '"Number": ' + CAST(Number AS NVARCHAR) + ', ' +
        '"Type": "' + Type + '", ' +
        '"Length": ' + CAST(Length AS NVARCHAR) + ', ' +
        '"Width": ' + CAST(Width AS NVARCHAR) + ', ' +
        '"Height": ' + CAST(Height AS NVARCHAR) + ', ' +
        '"Weight": ' + CAST(Weight AS NVARCHAR) + ', ' +
        '"IsEmpty": ' + CAST(IsEmpty AS NVARCHAR) + ', ' +
        '"ArrivalDate": "' + FORMAT(ArrivalDate, 'yyyy-MM-ddTHH:mm:ss') + '"}', 
        ',') + 
    ']'
FROM Containers;


-- 	Напишите запрос, выбирающий из второй таблицы все данные по операциям
--  для определенного контейнера в формате JSON не используя встроенную функцию



DECLARE @ContainerID UNIQUEIDENTIFIER = 'значение id';  

SELECT 
    '[' + STUFF((
        SELECT 
            ',{"OperationID": "' + CAST(OperationID AS NVARCHAR(36)) + '", ' +
            '"ContainerID": "' + CAST(ContainerID AS NVARCHAR(36)) + '", ' +
            '"StartDate": "' + FORMAT(StartDate, 'yyyy-MM-ddTHH:mm:ss') + '", ' +
            '"EndDate": "' + FORMAT(EndDate, 'yyyy-MM-ddTHH:mm:ss') + '", ' +
            '"OperationType": "' + OperationType + '", ' +
            '"OperatorName": "' + OperatorName + '", ' +
            '"InspectionLocation": "' + InspectionLocation + '"}'
        FROM 
            Operations
        WHERE 
            ContainerID = @ContainerID
        FOR XML PATH(''), TYPE).value('.', 'NVARCHAR(MAX)'), 1, 1, '') + 
    ']'

