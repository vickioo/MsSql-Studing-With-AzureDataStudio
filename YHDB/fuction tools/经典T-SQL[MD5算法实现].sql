USE YH100
GO

IF EXISTS(SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[dbo].[MD5_m_OnBits]') AND xtype IN(N'FN', N'IF', N'TF'))
DROP FUNCTION [dbo].[MD5_m_OnBits]
GO
/*****************************************************************************
* Name: MD5_m_OnBits
* Description: 常数组
*****************************************************************************/
CREATE FUNCTION dbo.MD5_m_OnBits(
@i TINYINT
)
RETURNS INT
-- WITH ENCRYPTION
AS
BEGIN
DECLARE @iRes INT
SELECT @iRes =
CASE @i
WHEN 0 THEN 1 -- 00000000000000000000000000000001
WHEN 1 THEN 3 -- 00000000000000000000000000000011
WHEN 2 THEN 7 -- 00000000000000000000000000000111
WHEN 3 THEN 15 -- 00000000000000000000000000001111
WHEN 4 THEN 31 -- 00000000000000000000000000011111
WHEN 5 THEN 63 -- 00000000000000000000000000111111
WHEN 6 THEN 127 -- 00000000000000000000000001111111
WHEN 7 THEN 255 -- 00000000000000000000000011111111
WHEN 8 THEN 511 -- 00000000000000000000000111111111
WHEN 9 THEN 1023 -- 00000000000000000000001111111111
WHEN 10 THEN 2047 -- 00000000000000000000011111111111
WHEN 11 THEN 4095 -- 00000000000000000000111111111111
WHEN 12 THEN 8191 -- 00000000000000000001111111111111
WHEN 13 THEN 16383 -- 00000000000000000011111111111111
WHEN 14 THEN 32767 -- 00000000000000000111111111111111
WHEN 15 THEN 65535 -- 00000000000000001111111111111111
WHEN 16 THEN 131071 -- 00000000000000011111111111111111
WHEN 17 THEN 262143 -- 00000000000000111111111111111111
WHEN 18 THEN 524287 -- 00000000000001111111111111111111
WHEN 19 THEN 1048575 -- 00000000000011111111111111111111
WHEN 20 THEN 2097151 -- 00000000000111111111111111111111
WHEN 21 THEN 4194303 -- 00000000001111111111111111111111
WHEN 22 THEN 8388607 -- 00000000011111111111111111111111
WHEN 23 THEN 16777215 -- 00000000111111111111111111111111
WHEN 24 THEN 33554431 -- 00000001111111111111111111111111
WHEN 25 THEN 67108863 -- 00000011111111111111111111111111
WHEN 26 THEN 134217727 -- 00000111111111111111111111111111
WHEN 27 THEN 268435455 -- 00001111111111111111111111111111
WHEN 28 THEN 536870911 -- 00011111111111111111111111111111
WHEN 29 THEN 1073741823 -- 00111111111111111111111111111111
WHEN 30 THEN 2147483647 -- 01111111111111111111111111111111
ELSE 0
END
RETURN(@iRes)
END
GO
IF EXISTS(SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[dbo].[MD5_m_2Power]') AND xtype IN(N'FN', N'IF', N'TF'))
DROP FUNCTION [dbo].[MD5_m_2Power]
GO
/*****************************************************************************
* Name: MD5_m_2Power
* Description: 常数组
*****************************************************************************/
CREATE FUNCTION dbo.MD5_m_2Power(
@i TINYINT
)
RETURNS INT
-- WITH ENCRYPTION
AS
BEGIN
DECLARE @iRes INT
SELECT @iRes =
CASE @i
WHEN 0 THEN 1 -- 00000000000000000000000000000001
WHEN 1 THEN 2 -- 00000000000000000000000000000010
WHEN 2 THEN 4 -- 00000000000000000000000000000100
WHEN 3 THEN 8 -- 00000000000000000000000000001000
WHEN 4 THEN 16 -- 00000000000000000000000000010000
WHEN 5 THEN 32 -- 00000000000000000000000000100000
WHEN 6 THEN 64 -- 00000000000000000000000001000000
WHEN 7 THEN 128 -- 00000000000000000000000010000000
WHEN 8 THEN 256 -- 00000000000000000000000100000000
WHEN 9 THEN 512 -- 00000000000000000000001000000000
WHEN 10 THEN 1024 -- 00000000000000000000010000000000
WHEN 11 THEN 2048 -- 00000000000000000000100000000000
WHEN 12 THEN 4096 -- 00000000000000000001000000000000
WHEN 13 THEN 8192 -- 00000000000000000010000000000000
WHEN 14 THEN 16384 -- 00000000000000000100000000000000
WHEN 15 THEN 32768 -- 00000000000000001000000000000000
WHEN 16 THEN 65536 -- 00000000000000010000000000000000
WHEN 17 THEN 131072 -- 00000000000000100000000000000000
WHEN 18 THEN 262144 -- 00000000000001000000000000000000
WHEN 19 THEN 524288 -- 00000000000010000000000000000000
WHEN 20 THEN 1048576 -- 00000000000100000000000000000000
WHEN 21 THEN 2097152 -- 00000000001000000000000000000000
WHEN 22 THEN 4194304 -- 00000000010000000000000000000000
WHEN 23 THEN 8388608 -- 00000000100000000000000000000000
WHEN 24 THEN 16777216 -- 00000001000000000000000000000000
WHEN 25 THEN 33554432 -- 00000010000000000000000000000000
WHEN 26 THEN 67108864 -- 00000100000000000000000000000000
WHEN 27 THEN 134217728 -- 00001000000000000000000000000000
WHEN 28 THEN 268435456 -- 00010000000000000000000000000000
WHEN 29 THEN 536870912 -- 00100000000000000000000000000000
WHEN 30 THEN 1073741824 -- 01000000000000000000000000000000
ELSE 0
END
RETURN(@iRes)
END
GO
IF EXISTS(SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[dbo].[MD5_LShift]') AND xtype IN(N'FN', N'IF', N'TF'))
DROP FUNCTION [dbo].[MD5_LShift]
GO
/*****************************************************************************
* Name: MD5_LShift
* Description: MD5_LShift
*****************************************************************************/
CREATE FUNCTION dbo.MD5_LShift(
@ivalue INT
,@iShiftBits TINYINT
)
RETURNS INT
-- WITH ENCRYPTION
AS
BEGIN
DECLARE @iRes BIGINT
SET @iRes = CAST(@ivalue AS BINARY(8))
SET @iRes = @iRes * dbo.MD5_m_2Power(@iShiftBits)
RETURN(CAST(@iRes & 0x00000000FFFFFFFF AS BINARY(4)))
END
GO
IF EXISTS(SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[dbo].[MD5_RShift]') AND xtype IN(N'FN', N'IF', N'TF'))
DROP FUNCTION [dbo].[MD5_RShift]
GO
/*****************************************************************************
* Name: MD5_RShift
* Description: MD5_RShift
*****************************************************************************/
CREATE FUNCTION dbo.MD5_RShift(
@ivalue INT
,@iShiftBits TINYINT
)
RETURNS INT
-- WITH ENCRYPTION
AS
BEGIN
DECLARE @iRes BIGINT
SET @iRes = CAST(@ivalue AS BINARY(8))
SET @iRes = @iRes / dbo.MD5_m_2Power(@iShiftBits)
RETURN(CAST(@iRes & 0x00000000FFFFFFFF AS BINARY(4)))
END
GO
IF EXISTS(SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[dbo].[MD5_RotateLeft]') AND xtype IN(N'FN', N'IF', N'TF'))
DROP FUNCTION [dbo].[MD5_RotateLeft]
GO
/*****************************************************************************
* Name: MD5_RotateLeft
* Description: MD5_RotateLeft
*****************************************************************************/
CREATE FUNCTION dbo.MD5_RotateLeft(
@ivalue INT
,@iShiftBits TINYINT
)
RETURNS INT
-- WITH ENCRYPTION
AS
BEGIN
RETURN(dbo.MD5_LShift(@ivalue, @iShiftBits) | dbo.MD5_RShift(@ivalue, (32 - @iShiftBits)))
END
GO
IF EXISTS(SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[dbo].[MD5_AddUnsigned]') AND xtype IN(N'FN', N'IF', N'TF'))
DROP FUNCTION [dbo].[MD5_AddUnsigned]
GO
/*****************************************************************************
* Name: MD5_AddUnsigned
* Description: MD5_AddUnsigned
*****************************************************************************/
CREATE FUNCTION dbo.MD5_AddUnsigned(
@iX INT
,@iY INT
)
RETURNS INT
-- WITH ENCRYPTION
AS
BEGIN
DECLARE @iRes BIGINT
SET @iRes = CAST(CAST(@iX AS BINARY(8)) AS BIGINT) + CAST(CAST(@iY AS BINARY(8)) AS BIGINT)
RETURN(CAST(@iRes & 0x00000000FFFFFFFF AS BINARY(4)))
END
GO
IF EXISTS(SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[dbo].[MD5_F]') AND xtype IN(N'FN', N'IF', N'TF'))
DROP FUNCTION [dbo].[MD5_F]
GO
/*****************************************************************************
* Name: MD5_F
* Description: MD5_F
*****************************************************************************/
CREATE FUNCTION dbo.MD5_F(
@x INT
,@y INT
,@z INT
)
RETURNS INT
-- WITH ENCRYPTION
AS
BEGIN
RETURN((@x & @y) | ((~@x) & @z))
END
GO
IF EXISTS(SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[dbo].[MD5_G]') AND xtype IN(N'FN', N'IF', N'TF'))
DROP FUNCTION [dbo].[MD5_G]
GO
/*****************************************************************************
* Name: MD5_G
* Description: MD5_G
*****************************************************************************/
CREATE FUNCTION dbo.MD5_G(
@x INT
,@y INT
,@z INT
)
RETURNS INT
-- WITH ENCRYPTION
AS
BEGIN
RETURN((@x & @z) | (@y & (~@z)))
END
GO
IF EXISTS(SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[dbo].[MD5_H]') AND xtype IN(N'FN', N'IF', N'TF'))
DROP FUNCTION [dbo].[MD5_H]
GO
/*****************************************************************************
* Name: MD5_H
* Description: MD5_H
*****************************************************************************/
CREATE FUNCTION dbo.MD5_H(
@x INT
,@y INT
,@z INT
)
RETURNS INT
-- WITH ENCRYPTION
AS
BEGIN
RETURN(@x ^ @y ^ @z)
END
GO
IF EXISTS(SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[dbo].[MD5_I]') AND xtype IN(N'FN', N'IF', N'TF'))
DROP FUNCTION [dbo].[MD5_I]
GO
/*****************************************************************************
* Name: MD5_I
* Description: MD5_I
*****************************************************************************/
CREATE FUNCTION dbo.MD5_I(
@x INT
,@y INT
,@z INT
)
RETURNS INT
-- WITH ENCRYPTION
AS
BEGIN
RETURN(@y ^ (@x | (~@z)))
END
GO
IF EXISTS(SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[dbo].[MD5_FF]') AND xtype IN(N'FN', N'IF', N'TF'))
DROP FUNCTION [dbo].[MD5_FF]
GO
/*****************************************************************************
* Name: MD5_FF
* Description: MD5_FF
*****************************************************************************/
CREATE FUNCTION dbo.MD5_FF(
@a INT
,@b INT
,@c INT
,@d INT
,@x INT
,@s INT
,@ac INT
)
RETURNS INT
-- WITH ENCRYPTION
AS
BEGIN
SET @a = dbo.MD5_AddUnsigned(@a, dbo.MD5_AddUnsigned(dbo.MD5_AddUnsigned(dbo.MD5_F(@b, @c, @d), @x), @ac))
SET @a = dbo.MD5_RotateLeft(@a, @s)
SET @a = dbo.MD5_AddUnsigned(@a, @b)
RETURN(@a)
END
GO
IF EXISTS(SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[dbo].[MD5_GG]') AND xtype IN(N'FN', N'IF', N'TF'))
DROP FUNCTION [dbo].[MD5_GG]
GO
/*****************************************************************************
* Name: MD5_GG
* Description: MD5_GG
*****************************************************************************/
CREATE FUNCTION dbo.MD5_GG(
@a INT
,@b INT
,@c INT
,@d INT
,@x INT
,@s INT
,@ac INT
)
RETURNS INT
-- WITH ENCRYPTION
AS
BEGIN
SET @a = dbo.MD5_AddUnsigned(@a, dbo.MD5_AddUnsigned(dbo.MD5_AddUnsigned(dbo.MD5_G(@b, @c, @d), @x), @ac))
SET @a = dbo.MD5_RotateLeft(@a, @s)
SET @a = dbo.MD5_AddUnsigned(@a, @b)
RETURN(@a)
END
GO
IF EXISTS(SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[dbo].[MD5_HH]') AND xtype IN(N'FN', N'IF', N'TF'))
DROP FUNCTION [dbo].[MD5_HH]
GO
/*****************************************************************************
* Name: MD5_HH
* Description: MD5_HH
*****************************************************************************/
CREATE FUNCTION dbo.MD5_HH(
@a INT
,@b INT
,@c INT
,@d INT
,@x INT
,@s INT
,@ac INT
)
RETURNS INT
-- WITH ENCRYPTION
AS
BEGIN
SET @a = dbo.MD5_AddUnsigned(@a, dbo.MD5_AddUnsigned(dbo.MD5_AddUnsigned(dbo.MD5_H(@b, @c, @d), @x), @ac))
SET @a = dbo.MD5_RotateLeft(@a, @s)
SET @a = dbo.MD5_AddUnsigned(@a, @b)
RETURN(@a)
END
GO


IF EXISTS(SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[dbo].[MD5_II]') AND xtype IN(N'FN', N'IF', N'TF'))
DROP FUNCTION [dbo].[MD5_II]
GO
/*****************************************************************************
* Name: MD5_II
* Description: MD5_II
*****************************************************************************/
CREATE FUNCTION dbo.MD5_II(
@a INT
,@b INT
,@c INT
,@d INT
,@x INT
,@s INT
,@ac INT
)
RETURNS INT
-- WITH ENCRYPTION
AS
BEGIN
SET @a = dbo.MD5_AddUnsigned(@a, dbo.MD5_AddUnsigned(dbo.MD5_AddUnsigned(dbo.MD5_I(@b, @c, @d), @x), @ac))
SET @a = dbo.MD5_RotateLeft(@a, @s)
SET @a = dbo.MD5_AddUnsigned(@a, @b)
RETURN(@a)
END
GO
IF EXISTS(SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[dbo].[MD5_ConvertToWordArray]') AND xtype IN(N'FN', N'IF', N'TF'))
DROP FUNCTION [dbo].[MD5_ConvertToWordArray]
GO
/*****************************************************************************
* Name: MD5_ConvertToWordArray
* Description: MD5_ConvertToWordArray
*****************************************************************************/
CREATE FUNCTION dbo.MD5_ConvertToWordArray(
@sOrigMess VARCHAR(8000) = ''
)
RETURNS @tWordArray TABLE([ID] INT IDENTITY(0,1),[Word] INT)
-- WITH ENCRYPTION
AS
BEGIN
IF @sOrigMess IS NULL
SET @sOrigMess = ''
DECLARE @iLenOfMess INT
DECLARE @iWordArrayLen INT
DECLARE @iPosOfWord INT
DECLARE @iPosOfMess INT
DECLARE @iCountOfWord INT
SET @iLenOfMess = LEN(@sOrigMess)
SET @iWordArrayLen = ((@iLenOfMess + 8)/64 + 1) * 16
SET @iCountOfWord = 0
WHILE(@iCountOfWord<@iWordArrayLen)
BEGIN
INSERT INTO @tWordArray([Word]) valueS(0)
SET @iCountOfWord = @iCountOfWord + 1
END
SELECT @iPosOfMess = 0, @iPosOfWord = 0, @iCountOfWord = 0
WHILE(@iPosOfMess < @iLenOfMess)
BEGIN
SELECT @iCountOfWord = @iPosOfMess / 4, @iPosOfWord = @iPosOfMess % 4
UPDATE @tWordArray
SET [Word] = [Word] | dbo.MD5_LShift(UNICODE(SUBSTRING(@sOrigMess,@iPosOfMess+1,1)),@iPosOfWord*8)
WHERE [ID] = @iCountOfWord
SET @iPosOfMess = @iPosOfMess + 1
END
SELECT @iCountOfWord = @iPosOfMess / 4, @iPosOfWord = @iPosOfMess % 4
UPDATE @tWordArray
SET [Word] = [Word] | dbo.MD5_LShift(0x80,@iPosOfWord*8)
WHERE [ID] = @iCountOfWord
UPDATE @tWordArray
SET [Word] = [Word] | dbo.MD5_LShift(@iLenOfMess,3)
WHERE [ID] = @iWordArrayLen - 2
UPDATE @tWordArray
SET [Word] = [Word] | dbo.MD5_RShift(@iLenOfMess,29)
WHERE [ID] = @iWordArrayLen - 1
RETURN
END
GO
IF EXISTS(SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[dbo].[MD5_WordToHex]') AND xtype IN(N'FN', N'IF', N'TF'))
DROP FUNCTION [dbo].[MD5_WordToHex]
GO
/*****************************************************************************
* Name: MD5_WordToHex
* Description: MD5_WordToHex
*****************************************************************************/
CREATE FUNCTION dbo.MD5_WordToHex(
@ivalue INT
)
RETURNS CHAR(8)
-- WITH ENCRYPTION
AS
BEGIN
DECLARE @sRes VARCHAR(8)
DECLARE @iTmp INT
DECLARE @iCount TINYINT
SELECT @sRes = '', @iCount = 0
WHILE(@iCount<4)
BEGIN
SET @iTmp = dbo.MD5_RShift(@ivalue,@iCount*8) & 0x000000FF
SET @sRes = @sRes + CASE @iTmp / 16 WHEN 0 THEN '0'
WHEN 1 THEN '1'
WHEN 2 THEN '2'
WHEN 3 THEN '3'
WHEN 4 THEN '4'
WHEN 5 THEN '5'
WHEN 6 THEN '6'
WHEN 7 THEN '7'
WHEN 8 THEN '8'
WHEN 9 THEN '9'
WHEN 10 THEN 'A'
WHEN 11 THEN 'B'
WHEN 12 THEN 'C'
WHEN 13 THEN 'D'
WHEN 14 THEN 'E'
WHEN 15 THEN 'F'
ELSE '' END
+ CASE @iTmp % 16 WHEN 0 THEN '0'
WHEN 1 THEN '1'
WHEN 2 THEN '2'
WHEN 3 THEN '3'
WHEN 4 THEN '4'
WHEN 5 THEN '5'
WHEN 6 THEN '6'
WHEN 7 THEN '7'
WHEN 8 THEN '8'
WHEN 9 THEN '9'
WHEN 10 THEN 'A'
WHEN 11 THEN 'B'
WHEN 12 THEN 'C'
WHEN 13 THEN 'D'
WHEN 14 THEN 'E'
WHEN 15 THEN 'F'
ELSE '' END
SET @iCount = @iCount + 1
END
RETURN(@sRes)
END
GO
IF EXISTS(SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[dbo].[MD5]') AND xtype IN(N'FN', N'IF', N'TF'))
DROP FUNCTION [dbo].[MD5]
GO
/*****************************************************************************
* Name: MD5
* Description: MD5
* 为处理大文本校验解析，修改原版NVARCHAR(4000)为 MAX
*****************************************************************************/
CREATE FUNCTION dbo.MD5(
@sOrigMess NVARCHAR(MAX)
)
RETURNS CHAR(32)
-- WITH ENCRYPTION
AS
BEGIN
--====================================
DECLARE @S11 TINYINT
DECLARE @S12 TINYINT
DECLARE @S13 TINYINT
DECLARE @S14 TINYINT
DECLARE @S21 TINYINT
DECLARE @S22 TINYINT
DECLARE @S23 TINYINT
DECLARE @S24 TINYINT
DECLARE @S31 TINYINT
DECLARE @S32 TINYINT
DECLARE @S33 TINYINT
DECLARE @S34 TINYINT
DECLARE @S41 TINYINT
DECLARE @S42 TINYINT
DECLARE @S43 TINYINT
DECLARE @S44 TINYINT
SELECT @S11 = 7, @S12 = 12, @S13 = 17, @S14 = 22
SELECT @S21 = 5, @S22 = 9, @S23 = 14, @S24 = 20
SELECT @S31 = 4, @S32 = 11, @S33 = 16, @S34 = 23
SELECT @S41 = 6, @S42 = 10, @S43 = 15, @S44 = 21
--====================================
DECLARE @a INT
DECLARE @b INT
DECLARE @c INT
DECLARE @d INT
DECLARE @AA INT
DECLARE @BB INT
DECLARE @CC INT
DECLARE @DD INT
SELECT @a = 0x67452301
,@b = 0xEFCDAB89
,@c = 0x98BADCFE
,@d = 0x10325476
--====================================
DECLARE @sRes VARCHAR(32)
SET @sRes = ''
DECLARE @iWordArrayLen INT
DECLARE @iWordArrayCount INT
DECLARE @tTmp TABLE([ID] INT, [Word] INT)
INSERT INTO @tTmp SELECT * FROM dbo.MD5_ConvertToWordArray(@sOrigMess)
SELECT @iWordArrayCount=0, @iWordArrayLen = COUNT(*) FROM @tTmp
WHILE(@iWordArrayCount < @iWordArrayLen)
BEGIN
SELECT @AA = @a, @BB = @b, @CC = @c, @DD = @d
SELECT @a = dbo.MD5_FF(@a, @b, @c, @d, (SELECT [Word] FROM @tTmp WHERE [ID] = @iWordArrayCount + 0), @S11, 0xD76AA478)
SELECT @d = dbo.MD5_FF(@d, @a, @b, @c, (SELECT [Word] FROM @tTmp WHERE [ID] = @iWordArrayCount + 1), @S12, 0xE8C7B756)
SELECT @c = dbo.MD5_FF(@c, @d, @a, @b, (SELECT [Word] FROM @tTmp WHERE [ID] = @iWordArrayCount + 2), @S13, 0x242070DB)
SELECT @b = dbo.MD5_FF(@b, @c, @d, @a, (SELECT [Word] FROM @tTmp WHERE [ID] = @iWordArrayCount + 3), @S14, 0xC1BDCEEE)
SELECT @a = dbo.MD5_FF(@a, @b, @c, @d, (SELECT [Word] FROM @tTmp WHERE [ID] = @iWordArrayCount + 4), @S11, 0xF57C0FAF)
SELECT @d = dbo.MD5_FF(@d, @a, @b, @c, (SELECT [Word] FROM @tTmp WHERE [ID] = @iWordArrayCount + 5), @S12, 0x4787C62A)
SELECT @c = dbo.MD5_FF(@c, @d, @a, @b, (SELECT [Word] FROM @tTmp WHERE [ID] = @iWordArrayCount + 6), @S13, 0xA8304613)
SELECT @b = dbo.MD5_FF(@b, @c, @d, @a, (SELECT [Word] FROM @tTmp WHERE [ID] = @iWordArrayCount + 7), @S14, 0xFD469501)
SELECT @a = dbo.MD5_FF(@a, @b, @c, @d, (SELECT [Word] FROM @tTmp WHERE [ID] = @iWordArrayCount + 8), @S11, 0x698098D8)
SELECT @d = dbo.MD5_FF(@d, @a, @b, @c, (SELECT [Word] FROM @tTmp WHERE [ID] = @iWordArrayCount + 9), @S12, 0x8B44F7AF)
SELECT @c = dbo.MD5_FF(@c, @d, @a, @b, (SELECT [Word] FROM @tTmp WHERE [ID] = @iWordArrayCount + 10), @S13, 0xFFFF5BB1)
SELECT @b = dbo.MD5_FF(@b, @c, @d, @a, (SELECT [Word] FROM @tTmp WHERE [ID] = @iWordArrayCount + 11), @S14, 0x895CD7BE)
SELECT @a = dbo.MD5_FF(@a, @b, @c, @d, (SELECT [Word] FROM @tTmp WHERE [ID] = @iWordArrayCount + 12), @S11, 0x6B901122)
SELECT @d = dbo.MD5_FF(@d, @a, @b, @c, (SELECT [Word] FROM @tTmp WHERE [ID] = @iWordArrayCount + 13), @S12, 0xFD987193)
SELECT @c = dbo.MD5_FF(@c, @d, @a, @b, (SELECT [Word] FROM @tTmp WHERE [ID] = @iWordArrayCount + 14), @S13, 0xA679438E)
SELECT @b = dbo.MD5_FF(@b, @c, @d, @a, (SELECT [Word] FROM @tTmp WHERE [ID] = @iWordArrayCount + 15), @S14, 0x49B40821)
SELECT @a = dbo.MD5_GG(@a, @b, @c, @d, (SELECT [Word] FROM @tTmp WHERE [ID] = @iWordArrayCount + 1), @S21, 0xF61E2562)
SELECT @d = dbo.MD5_GG(@d, @a, @b, @c, (SELECT [Word] FROM @tTmp WHERE [ID] = @iWordArrayCount + 6), @S22, 0xC040B340)
SELECT @c = dbo.MD5_GG(@c, @d, @a, @b, (SELECT [Word] FROM @tTmp WHERE [ID] = @iWordArrayCount + 11), @S23, 0x265E5A51)
SELECT @b = dbo.MD5_GG(@b, @c, @d, @a, (SELECT [Word] FROM @tTmp WHERE [ID] = @iWordArrayCount + 0), @S24, 0xE9B6C7AA)
SELECT @a = dbo.MD5_GG(@a, @b, @c, @d, (SELECT [Word] FROM @tTmp WHERE [ID] = @iWordArrayCount + 5), @S21, 0xD62F105D)
SELECT @d = dbo.MD5_GG(@d, @a, @b, @c, (SELECT [Word] FROM @tTmp WHERE [ID] = @iWordArrayCount + 10), @S22, 0x2441453)
SELECT @c = dbo.MD5_GG(@c, @d, @a, @b, (SELECT [Word] FROM @tTmp WHERE [ID] = @iWordArrayCount + 15), @S23, 0xD8A1E681)
SELECT @b = dbo.MD5_GG(@b, @c, @d, @a, (SELECT [Word] FROM @tTmp WHERE [ID] = @iWordArrayCount + 4), @S24, 0xE7D3FBC8)
SELECT @a = dbo.MD5_GG(@a, @b, @c, @d, (SELECT [Word] FROM @tTmp WHERE [ID] = @iWordArrayCount + 9), @S21, 0x21E1CDE6)
SELECT @d = dbo.MD5_GG(@d, @a, @b, @c, (SELECT [Word] FROM @tTmp WHERE [ID] = @iWordArrayCount + 14), @S22, 0xC33707D6)
SELECT @c = dbo.MD5_GG(@c, @d, @a, @b, (SELECT [Word] FROM @tTmp WHERE [ID] = @iWordArrayCount + 3), @S23, 0xF4D50D87)
SELECT @b = dbo.MD5_GG(@b, @c, @d, @a, (SELECT [Word] FROM @tTmp WHERE [ID] = @iWordArrayCount + 8), @S24, 0x455A14ED)
SELECT @a = dbo.MD5_GG(@a, @b, @c, @d, (SELECT [Word] FROM @tTmp WHERE [ID] = @iWordArrayCount + 13), @S21, 0xA9E3E905)
SELECT @d = dbo.MD5_GG(@d, @a, @b, @c, (SELECT [Word] FROM @tTmp WHERE [ID] = @iWordArrayCount + 2), @S22, 0xFCEFA3F8)
SELECT @c = dbo.MD5_GG(@c, @d, @a, @b, (SELECT [Word] FROM @tTmp WHERE [ID] = @iWordArrayCount + 7), @S23, 0x676F02D9)
SELECT @b = dbo.MD5_GG(@b, @c, @d, @a, (SELECT [Word] FROM @tTmp WHERE [ID] = @iWordArrayCount + 12), @S24, 0x8D2A4C8A)
SELECT @a = dbo.MD5_HH(@a, @b, @c, @d, (SELECT [Word] FROM @tTmp WHERE [ID] = @iWordArrayCount + 5), @S31, 0xFFFA3942)
SELECT @d = dbo.MD5_HH(@d, @a, @b, @c, (SELECT [Word] FROM @tTmp WHERE [ID] = @iWordArrayCount + 8), @S32, 0x8771F681)
SELECT @c = dbo.MD5_HH(@c, @d, @a, @b, (SELECT [Word] FROM @tTmp WHERE [ID] = @iWordArrayCount + 11), @S33, 0x6D9D6122)
SELECT @b = dbo.MD5_HH(@b, @c, @d, @a, (SELECT [Word] FROM @tTmp WHERE [ID] = @iWordArrayCount + 14), @S34, 0xFDE5380C)
SELECT @a = dbo.MD5_HH(@a, @b, @c, @d, (SELECT [Word] FROM @tTmp WHERE [ID] = @iWordArrayCount + 1), @S31, 0xA4BEEA44)
SELECT @d = dbo.MD5_HH(@d, @a, @b, @c, (SELECT [Word] FROM @tTmp WHERE [ID] = @iWordArrayCount + 4), @S32, 0x4BDECFA9)
SELECT @c = dbo.MD5_HH(@c, @d, @a, @b, (SELECT [Word] FROM @tTmp WHERE [ID] = @iWordArrayCount + 7), @S33, 0xF6BB4B60)
SELECT @b = dbo.MD5_HH(@b, @c, @d, @a, (SELECT [Word] FROM @tTmp WHERE [ID] = @iWordArrayCount + 10), @S34, 0xBEBFBC70)
SELECT @a = dbo.MD5_HH(@a, @b, @c, @d, (SELECT [Word] FROM @tTmp WHERE [ID] = @iWordArrayCount + 13), @S31, 0x289B7EC6)
SELECT @d = dbo.MD5_HH(@d, @a, @b, @c, (SELECT [Word] FROM @tTmp WHERE [ID] = @iWordArrayCount + 0), @S32, 0xEAA127FA)
SELECT @c = dbo.MD5_HH(@c, @d, @a, @b, (SELECT [Word] FROM @tTmp WHERE [ID] = @iWordArrayCount + 3), @S33, 0xD4EF3085)
SELECT @b = dbo.MD5_HH(@b, @c, @d, @a, (SELECT [Word] FROM @tTmp WHERE [ID] = @iWordArrayCount + 6), @S34, 0x4881D05)
SELECT @a = dbo.MD5_HH(@a, @b, @c, @d, (SELECT [Word] FROM @tTmp WHERE [ID] = @iWordArrayCount + 9), @S31, 0xD9D4D039)
SELECT @d = dbo.MD5_HH(@d, @a, @b, @c, (SELECT [Word] FROM @tTmp WHERE [ID] = @iWordArrayCount + 12), @S32, 0xE6DB99E5)
SELECT @c = dbo.MD5_HH(@c, @d, @a, @b, (SELECT [Word] FROM @tTmp WHERE [ID] = @iWordArrayCount + 15), @S33, 0x1FA27CF8)
SELECT @b = dbo.MD5_HH(@b, @c, @d, @a, (SELECT [Word] FROM @tTmp WHERE [ID] = @iWordArrayCount + 2), @S34, 0xC4AC5665)
SELECT @a = dbo.MD5_II(@a, @b, @c, @d, (SELECT [Word] FROM @tTmp WHERE [ID] = @iWordArrayCount + 0), @S41, 0xF4292244)
SELECT @d = dbo.MD5_II(@d, @a, @b, @c, (SELECT [Word] FROM @tTmp WHERE [ID] = @iWordArrayCount + 7), @S42, 0x432AFF97)
SELECT @c = dbo.MD5_II(@c, @d, @a, @b, (SELECT [Word] FROM @tTmp WHERE [ID] = @iWordArrayCount + 14), @S43, 0xAB9423A7)
SELECT @b = dbo.MD5_II(@b, @c, @d, @a, (SELECT [Word] FROM @tTmp WHERE [ID] = @iWordArrayCount + 5), @S44, 0xFC93A039)
SELECT @a = dbo.MD5_II(@a, @b, @c, @d, (SELECT [Word] FROM @tTmp WHERE [ID] = @iWordArrayCount + 12), @S41, 0x655B59C3)
SELECT @d = dbo.MD5_II(@d, @a, @b, @c, (SELECT [Word] FROM @tTmp WHERE [ID] = @iWordArrayCount + 3), @S42, 0x8F0CCC92)
SELECT @c = dbo.MD5_II(@c, @d, @a, @b, (SELECT [Word] FROM @tTmp WHERE [ID] = @iWordArrayCount + 10), @S43, 0xFFEFF47D)
SELECT @b = dbo.MD5_II(@b, @c, @d, @a, (SELECT [Word] FROM @tTmp WHERE [ID] = @iWordArrayCount + 1), @S44, 0x85845DD1)
SELECT @a = dbo.MD5_II(@a, @b, @c, @d, (SELECT [Word] FROM @tTmp WHERE [ID] = @iWordArrayCount + 8), @S41, 0x6FA87E4F)
SELECT @d = dbo.MD5_II(@d, @a, @b, @c, (SELECT [Word] FROM @tTmp WHERE [ID] = @iWordArrayCount + 15), @S42, 0xFE2CE6E0)
SELECT @c = dbo.MD5_II(@c, @d, @a, @b, (SELECT [Word] FROM @tTmp WHERE [ID] = @iWordArrayCount + 6), @S43, 0xA3014314)
SELECT @b = dbo.MD5_II(@b, @c, @d, @a, (SELECT [Word] FROM @tTmp WHERE [ID] = @iWordArrayCount + 13), @S44, 0x4E0811A1)
SELECT @a = dbo.MD5_II(@a, @b, @c, @d, (SELECT [Word] FROM @tTmp WHERE [ID] = @iWordArrayCount + 4), @S41, 0xF7537E82)
SELECT @d = dbo.MD5_II(@d, @a, @b, @c, (SELECT [Word] FROM @tTmp WHERE [ID] = @iWordArrayCount + 11), @S42, 0xBD3AF235)
SELECT @c = dbo.MD5_II(@c, @d, @a, @b, (SELECT [Word] FROM @tTmp WHERE [ID] = @iWordArrayCount + 2), @S43, 0x2AD7D2BB)
SELECT @b = dbo.MD5_II(@b, @c, @d, @a, (SELECT [Word] FROM @tTmp WHERE [ID] = @iWordArrayCount + 9), @S44, 0xEB86D391)
SET @a = dbo.MD5_AddUnsigned(@a, @AA)
SET @b = dbo.MD5_AddUnsigned(@b, @BB)
SET @c = dbo.MD5_AddUnsigned(@c, @CC)
SET @d = dbo.MD5_AddUnsigned(@d, @DD)
SET @iWordArrayCount = @iWordArrayCount + 16
END
SET @sRes = dbo.MD5_WordToHex(@a) + dbo.MD5_WordToHex(@b) + dbo.MD5_WordToHex(@c) + dbo.MD5_WordToHex(@d)
SET @sRes = LOWER(@sRes)
RETURN(@sRes)
END
GO

--Test
set nocount on

select dbo.MD5('') as 'MD5('''')'
union
select 'd41d8cd98f00b204e9800998ecf8427e'

select dbo.MD5('a') as 'MD5(''a'')'
union
select '0cc175b9c0f1b6a831c399e269772661'

select dbo.MD5('abc') as 'MD5(''abc'')'
union
select '900150983cd24fb0d6963f7d28e17f72'

select dbo.MD5('message digest') as 'MD5(''message digest'')'
union
select 'f96b697d7cb7938d525a2f31aaf161d0'

select dbo.MD5('abcdefghijklmnopqrstuvwxyz') as 'MD5(''abcdefghijklmnopqrstuvwxyz'')'
union
select 'c3fcd3d76192e4007dfb496cca67e13b'

select dbo.MD5('ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789') as 'MD5(''ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789'')'
union
select 'd174ab98d277d9f5a5611c2c9f419d9f'

select dbo.MD5('12345678901234567890123456789012345678901234567890123456789012345678901234567890') as 'MD5(''12345678901234567890123456789012345678901234567890123456789012345678901234567890'')'
union
select '57edf4a22be3c955ac49da2e2107b67a'

select dbo.MD5('我') as 'MD5(''我'')'
union
select 'a31d0f25367ebe046897f8a939ca4a9f'

-- select * from YH100.dbo.test04
select *, dbo.MD5(txt) as st_MD5
,hashbytes('md5', convert(varchar,txt)) as hs_MD5_bin
,dbo.MD5s(txt) as simple_MD5
,checksum(txt) cs
from YH100.dbo.bakuser_commtxt where name = 'vwtotab2'

-- MD5simple版弱点对比测试：无法正确识别汉字与字节长度超8000内容
select dbo.MD5s('', 32 ) as 'MD5('''')'
union
select 'd41d8cd98f00b204e9800998ecf8427e'

select dbo.MD5s('a', 32 ) as 'MD5(''a'')'
union
select '0cc175b9c0f1b6a831c399e269772661'

select dbo.MD5s('ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789', 32 ) as 'MD5(''ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789'')'
union
select 'd174ab98d277d9f5a5611c2c9f419d9f'

select dbo.MD5s('12345678901234567890123456789012345678901234567890123456789012345678901234567890', 32 ) as 'MD5(''12345678901234567890123456789012345678901234567890123456789012345678901234567890'')'
union
select '57edf4a22be3c955ac49da2e2107b67a'

select dbo.MD5s('我', 32 ) as 'MD5(''我'')'
union
select 'a31d0f25367ebe046897f8a939ca4a9f'