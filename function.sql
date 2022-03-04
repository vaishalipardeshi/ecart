USE [ecart1]
GO

/****** Object:  UserDefinedFunction [dbo].[OrderOnDate]    Script Date: 04-03-2022 10:23:06 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE function [dbo].[OrderOnDate](@StartDate date,@EndDate date)
returns table
as
return select u.name,p.product_name,o.order_date from order_tab as o inner join product_tab as p on o.product_id=p.product_id inner join
[ecart1].[dbo].[user_tab] as u on u.user_id=o.user_id
where order_date between @StartDate and @EndDate;
GO


