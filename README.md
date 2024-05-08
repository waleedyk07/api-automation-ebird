# Part 1
Two `GET` endpoints are automated.
1. Get Region Info
2. Get Recent Observations

## Get Region Info
### URL
https://api.ebird.org/v2/ref/region/info/PK

### Robot File Name
`{project_root}/tests/api/region.robot`

### Explanation of Usecases
1. Check response codes is `200`
2. Check the returned region type is `Country`
3. Check the returned region is `Pakistan`

## Get Recent Observations
### URL
https://api.ebird.org/v2/data/obs/PK/recent

### Robot File Name
`{project_root}/tests/api/observation.robot`

### Explanation of Usecases
1. Check response codes is `200`
2. Check returned observation list has size more than `0`

# Part 2
## Robot File Name
`{project_root}/tests/web/parabank.robot`

## Explanation of Usecases
1. Open the chrome browser
2. Open profile registeration page by click on `Register` button
3. Enter profile data and click register
4. Check if user is successfull register
5. Logout the new created user.
6. Open Same url in new tab
7. Enter `username` and `password` created on step 3 and 4.
8. Check if newly created user can successfully login.

# Part 3
## 1. Imagine you aim to utilize an API automation project for both web and mobile applications. What actions would you initiate?
1. I'll look for a swagger/open api document or a postman collection to through understand all relevant web services.
2. Will get understanding of data models.
3. Understand the sequence of CRUD APIs which complete a workflow or a usecase.
4. Use any API testing tool like postman or swagger to test each endpoint individually.
5. Run a manual test by manually completing a workflow with related APIs.
6. Pick a framework and start writing automation test cases.
7. Extend the framework by writing utilities. For example, authentication is going to be used on every API request. So, there is no need to write auth test every time, will write a utility to generate token and utilize it every use case.

## 2. Propose an example of contract testing for an e-commerce application and the theoretical implementation. What tools will you use?
As per best practices, API projects have swaggers that has contract definations in it like data models, authentication mechanisim and related details which define how APIs interact with each other.<br>In case there is no swagger, either we write a swagger or we can write a Postman collection for it.<br><br>
**Example:** `Get Auth Token from Auth API`=>`Get List of Stores`=>`Get List of Products by Store ID`=>`Get Details of Product by ID`=>`POST Product ID to Cart`.<br><br>
In above given example, each block is an endpoint, for which there are going to be separate usecase addionally there is going to be atleast 1 use case that complete the whole workflow consisting of all API calls in sequence.

# Project Details
## Framework
Python Robot Framework

## Project Structure
```
{project_root}
|   .gitignore
|   Dockerfile
|   entrypoint.sh       # Entry point for docker
|   README.md
|   requirements.txt
|
+---.github
|   \---workflows
|           robot-test-workflow.yml
|
+---libs
|   |   utils.py        # Customer Python Lib
|
+---resource
|   |   config.py       # Externalize Config/Variables
|
\---tests
    +---api             # API Automation Test Cases
    |       observation.robot
    |       region.robot
    |
    \---web             # Web Automation Test Cases
            parabank.robot
```
## Run in Local Host
Execute Command below command in `project_root`
```
robot --outputdir <OUTPUT DIRECTORY PATH> tests/.
```

## Run in Docker Container Locally
Make sure that `docker` deamon is running locally.
Execute Command below commands in `project_root`.
```
docker build --build-arg REPORT_PATH=reports -t api-automation-ebird .
```
```
docker run -v <OUTPUT DIRECTORY PATH>:/reports --rm api-automation-ebird
```
**Note:** Only API Automation runs inside docker container.

## Run in Github Actions
1. Goto `https://github.com/waleedyk07/api-automation-ebird`.
2. Click `Actions`.
3. Run `Robot Test` workflow.
4. Run workflow on `main` branch
5. Goto Summary once workflow runs successfully.
6. Download artifact.

**Note:** Only API Automation runs inside github actions.