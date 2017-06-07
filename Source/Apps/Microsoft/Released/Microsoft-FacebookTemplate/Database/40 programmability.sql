SET ANSI_NULLS              ON;
SET ANSI_PADDING            ON;
SET ANSI_WARNINGS           ON;
SET ANSI_NULL_DFLT_ON       ON;
SET CONCAT_NULL_YIELDS_NULL ON;
SET QUOTED_IDENTIFIER       ON;
go

CREATE PROCEDURE [fb].[Merge]
AS
BEGIN

---------------------Merge Comments-------------------------------------
BEGIN TRAN
DELETE t 
FROM fb.[Comments] as t
INNER JOIN fb.StagingComments s 
ON t.Id1 = s.Id1 AND t.Id2 = s.Id2;


INSERT INTO fb.[Comments]
(
     [Id1]
	,[Id2]
	,[Original Id]
	,[Created Date]
	,[Message]
	,[From Id]
	,[From Name]
	,[Post Id1]
	,[Post Id2]
	,[Original Post Id]
	,[Page]
    ,[PageDisplayName]
    ,[PageId]
)
SELECT DISTINCT
	 [Id1]
	,[Id2]
	,[Original Id]
	,[Created Date]
	,[Message]
	,[From Id]
	,[From Name]
	,[Post Id1]
	,[Post Id2]
	,[Original Post Id]
	,[Page]
    ,[PageDisplayName]
    ,[PageId]
 FROM fb.StagingComments
    
TRUNCATE TABLE [fb].[StagingComments];	 
COMMIT
---------------------Merge HashTags-------------------------------------

BEGIN TRAN
DELETE t 
FROM fb.HashTags as t
INNER JOIN fb.StagingHashTags s 
ON t.Id1 = s.Id1 AND t.Id2 = s.Id2;

INSERT INTO [fb].[HashTags] 
(
     [Id1]
	,[Id2]
	,[Original Id]
	,[HashTags]
)
SELECT DISTINCT   
	 [Id1]
	,[Id2]
	,[Original Id]
	,[HashTags]
FROM [fb].[StagingHashTags];

TRUNCATE TABLE [fb].[StagingHashTags];	 	 
COMMIT
---------------------Merge KeyPhrases-------------------------------------

BEGIN TRAN
DELETE t 
FROM fb.KeyPhrase as t
INNER JOIN fb.StagingKeyPhrase s 
ON t.Id1 = s.Id1 AND t.Id2 = s.Id2;

INSERT INTO [fb].[KeyPhrase] 
(
     [Id1]
	,[Id2]
	,[Original Id]
	,[KeyPhrase]
)
    
SELECT DISTINCT  
			[Id1]
		,[Id2]
		,[Original Id]
		,[KeyPhrase]
	FROM [fb].[StagingKeyPhrase];

TRUNCATE TABLE [fb].[StagingKeyPhrase];	 	 
COMMIT
---------------------Merge Posts-------------------------------------
BEGIN TRAN
DELETE t 
FROM fb.Posts as t
INNER JOIN fb.StagingPosts s 
ON t.Id1 = s.Id1 AND t.Id2 = s.Id2;

INSERT INTO fb.Posts
(
     [Id1]
	,[Id2]
	,[Original Id]
	,[Created Date]
	,[Message]
	,[From Id]
	,[From Name]
	,[Media]
	,[Total Likes]
	,[Total Shares]
	,[Total Reactions]
	,[Page]
    ,[PageDisplayName]
    ,[PageId]
    ,[Total Comments]
)
SELECT DISTINCT
     [Id1]
	,[Id2]
	,[Original Id]
	,[Created Date]
	,[Message]
	,[From Id]
	,[From Name]
	,[Media]
	,[Total Likes]
	,[Total Shares]
	,[Total Reactions]
	,[Page]
    ,[PageDisplayName]
    ,[PageId]
	,[Total Comments]
    FROM fb.StagingPosts
TRUNCATE TABLE [fb].StagingPosts;	 	 
COMMIT

---------------------Merge Reactions-------------------------------------
BEGIN TRAN
DELETE t 
FROM [fb].[Reactions] as t
INNER JOIN [fb].[StagingReactions] s 
ON t.Id1 = s.Id1 AND t.Id2 = s.Id2;

INSERT INTO [fb].[Reactions]
(
        [Id1]
	,[Id2]
	,[Original Id]
	,[Reaction Type]
	,[From Id]
	,[From Name]
)
SELECT DISTINCT  
		[Id1]
	,[Id2]
	,[Original Id]
	,[Reaction Type]
	,[From Id]
	,[From Name]
FROM [fb].[StagingReactions]
TRUNCATE TABLE [fb].[StagingReactions];	 	 
COMMIT

---------------------Merge Sentiment-------------------------------------
BEGIN TRAN
DELETE t 
FROM [fb].[Sentiment] as t
INNER JOIN [fb].[StagingSentiment] s 
ON t.Id1 = s.Id1 AND t.Id2 = s.Id2;
    
INSERT INTO [fb].[Sentiment]
(
        [Id1]
	,[Id2]
	,[Original Id]
	,[Sentiment]
)
SELECT DISTINCT
	[Id1]
	,[Id2]
	,[Original Id]
	,[Sentiment]
FROM [fb].[StagingSentiment]
TRUNCATE TABLE [fb].[StagingSentiment];	 	 
COMMIT

END
go
