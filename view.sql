USE [ecart1]
GO

/****** Object:  View [dbo].[userinfoview]    Script Date: 04-03-2022 10:25:49 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE or alter view [dbo].[userinfoview]
as select c.user_id, c.name,c.email,ad.pincode,ad.city 
from user_tab as c,address_tab as ad 
where c.user_id=ad.user_id;
GO


