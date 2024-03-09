# FinalProject:

- WoWContentCreator
- Created by Zack Nyman, Dylan Beppler, and Blake Vieyra

# Description:

- The WoWContentCreator project is a full-stack web application that allows the user to create novel in-game content ideas for the popular MMORPG World of Warcraft, created by Blizzard Entertainment. The user can create new content ides for the game, make comments on content created by other users, upvote or downvote content of other users, and view the latest content posted. The users can view and update their own content as well and see how it being received by the community.
  
- Deployed AWS EC2 Link: http://18.224.81.89:8080/WoWContentCreator

![image](https://github.com/DylanBeppler/FinalProject/assets/88246090/768a3a04-15c3-42fc-a25c-5deabf2f9b33)


# Key Features:

| HTTP Verb | URI               | Request Body | Response Body | Status Codes |
|-----------|-------------------|--------------|---------------|---------|
| GET       | `/api/content`      | JSON retrieval of all content | List of all content | 200, 404 |
| GET       | `/api/content/1`      | JSON retrieval of content id `1` | Retrieves of content with id `1` | 200, 404 |
| GET       | `/api/content/1/comments`   |  JSON of comments for content id `1` | Retrieves comments for content id `1`| 200, 404 |
| GET       | `/api/content/1/votes`   |  JSON of votes for content id `1` | Retrieves votes for content id `1`| 200, 404 |
| POST      | `/api/content/1/comments`      | JSON of a new comment for content id `1`  | JSON of created comment | 201, 400 |
| POST      | `/api/content/1/vote`      | JSON of a  new vote for content id `1` | JSON of created vote | 201, 400 |
| PUT       | `/api/content/1/comments/1`   | JSON of a new version of comment for content id `1` | JSON of updated artist | 201, 400 |
| PUT       | `/api/content/1/vote/1`    | JSON of a new version of vote for content id `1` | JSON of updated artist | 201, 400 |
| DELETE    | `/api/content/1`   | JSON of deletion of content `1` | JSON of deleted content id `1`| 204, 404, 400 |  
| DELETE    | `/api/content/1/comment/1`   | JSON of deletion of comment id `1` for content id `1` | JSON of deleted comment id `1` | 204, 404, 400 |  

       

# Tech Used:

Programming Languages:
- Java 8 (version 1.8.0_391)
- IDEs: Spring Tool Suite (STS) (https://spring.io/tools), Visual Code Studio Version: 1.86.2
- Version Control: Git 2.32.1 (https://git-scm.com/)
- Database Management: MySQL (version 5.7.39)
- Build Tool: Gradle
- Web Framework: Spring MVC, JPA, Restful API

# Lessons Learned:

- How to impliment Restful API JPA repositories and properly separate concerns between the services, controllers, and the repos.
- How to create and impliments angular services, bootstrap formatting and pipes to create a dynamic user interface
- How to create a database schema and model that allows for self-join tables and entities that map to themselves.





