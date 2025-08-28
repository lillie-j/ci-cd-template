# CI/CD Workflow Templates
This repository contains template files for CI/CD workflows (GitHub Actions), intended for use in Python-based projects.

It contains a very simple application, composed of a FastAPI backend and a Streamlit frontend. This application is for demonstrative purposes/to provide code over which CI/CD steps can run.


# 🛠️ Continuous Integration (CI) Workflows

**Continuous Integration** is the practice of automatically building, testing, and validating code changes to ensure quality and consistency throught the software development lifecycle. It allows you to quickly and confidently integrate changes into your codebase, whilst minimising manual steps and the risk of regressions. 

This repository includes 1 CI Workflow, `.github/workflows/CI Template.yaml`, which is designed to run using **GitHub Actions**. 

GitHub Actions defines CI/CD pipelines through YAML files. These files allow you to programmatically specify a sequence of steps/jobs that are executed by a GitHub-hosted runner.


## `CI Template.yaml`

### Overview
This workflow consists of 4 jobs. These are logically separated steps performed by the CI workflow.

#### 1. Setup 🏗️
Installs Python, your chosen dependency manager, and project dependencies.


#### 2. Test 🧪
Runs all tests using `pytest` and outputs a coverage report. Any test failures will cause this job to fail.


#### 3. Linting 🧹
Checks code style and quality using `flake8` and `pylint`. Also outputs a pylint score badge like ![badge](https://img.shields.io/badge/pylint-10.0-green) for use in your repo.


#### 4. Docker Build/Push 🐋
Builds your app into a Docker Image/Images, enabling them to run as a containerised service.

----------------------------------


### How to Use 🧑‍💻

#### 1. Clone Repo
The following folders need to be copied into your repo to make this workflow available

```py
# Clone the template repository
git clone https://github.com/lillie-j/ci-cd-template.git

# Copy required files into your project
cp -r ci-cd-template/.github <path/to/your/repo>
cp ci-cd-template/requirements.ci.txt <path/to/your/repo>
```

#### 2. Set Secrets

To push Docker images to a cloud registry, define the following secrets in your GitHub repository using **GitHub Secrets**. Access to cloud registry is expected via a service principal.

**NB**: Azure Push is still WIP 

| Cloud Provider   | Image Registry     | Secret Names                |
|------------------|--------------------|--------------------------|
| **AWS**  | Elastic Container Registry | AWS_ACCESS_KEY_ID, AWS_SECRET_ACCESS_KEY,AWS_REGION                  
| **Azure** | (Azure Container Registry) | AZURE_CREDS, AZURE_REGISTRY_NAME 


#### 3. Set Environment Variables
The behaviour of the workflow can be varied slightly depending on your requirements. This is done by modifying the following environment variables at the top of the workflow file.

| Variable                         | Used in Job        | Purpose     | Format  | Example|
|----------------------------------|--------------------|--------------------|---------------|-----------|
| **DEPENDENCY_MANAGER**           | 1. Setup 🏗️       | Choose which dependency manager to use to rebuild environment| `'uv'` `'pipenv'` `'venv'` | `'uv'`               
| **EXCLUDE_FOLDERS_FROM_LINTING** | 3. Linting 🧹     | Choose which folders to exclude from linting    | String list of folders (no need to define relative to root) | `'tests,src'`        
| **IGNORE_LINTING_FAILURES**      | 3. Linting 🧹     | Choose whether to fail job if linters detect issues | `'true'` `'false'` | `'true'`  
| **CLOUD_REGISTRY**               | 4. Docker Build 🐋| Choose which cloud provider hosts your image registry/to push to |  `'aws'` `'azure'` `'none'` | `'aws'`
| **BUILD_PLATFORM**               | 4. Docker Build 🐋| Choose which platform your Docker image should be built for | See Docker supported [build platforms](https://docs.docker.com/reference/cli/docker/buildx/build/) |  `'linux/amd64'`

#### 4. Set Matrix Variables
Matrix builds allow parallel execution of jobs with different inputs. In this workflow, the Docker Build job uses a matrix to build multiple images concurrently.

Environment variables cannot be easily injected into matrix variables, and so matrix variables need to be defined in line as below.


`ci-template.yaml`
```
  Docker_Build:
    needs: Test
    runs-on: ubuntu-latest
    strategy:
      fail-fast: false
      matrix:
        context: ["./src/backend","./src/frontend"] #EDIT THIS VARIABLE
        # Each path should point to a folder containing a Dockerfile.
        # Each Dockerfile is assumed to be in the same folder as its build context.
```
#### 5. Create Repos in Cloud Image Registries
When using this workflow to build and push Docker images to a cloud-based image registry (e.g., AWS ECR or Azure ACR), it's important to ensure that the repository name in your cloud registry matches the name of your GitHub repository.

For example, if your GitHub repository is named ci-cd-template, the workflow will attempt to push images to a container repository named ci-cd-template in your cloud provider's registry.

#### 6. Push Changes
Push changes to your remote repo and then raise a PR into `main`. This should trigger the workflow and validate whether it has been setup correctly.

---------------------------------------


## A Note on CodeQL & CI
CodeQL is a powerful static analysis tool developed by GitHub that scans your codebase for potential security vulnerabilities. It detects patterns that may indicate security flaws, such as SQL injection, cross-site scripting, etc.

CodeQL scans can be integrated directly into your CI/CD pipeline using custom workflow YAML files. Therefore, it *could* have been included in `CI Template.yaml`. However, for most use cases—especially for client demonstrators or non-production applications—CodeQL may be considered out of scope. Its primary value lies in securing production-grade applications with complex logic and external integrations. This is why it is not included in the template CI workflow.

If wanted, CodeQL can be more easily setup via the GitHub GUI. To enable this:

1. Navigate to your repository on GitHub.
2. Click Settings from the top navigation bar.
3. In the left-hand menu, go to Security > Code security and analysis.
4. Scroll down to the Code scanning section.
5. Click Set up CodeQL and follow the prompts to enable default analysis.
6. Optionally, configure the scan frequency and scope (e.g., branches, languages).

# 🚀 Continuous Deployment (CD) Workflows

Continuous Deployment is the practice of automatically releasing validated code changes to a target environment once they pass all required checks in CI. It extends the principles of CI by eliminating manual deployment steps, enabling faster and more reliable delivery of software.


## `CD Template.yaml` (COMING SOON)



# General Design Considerations
The following design patterns were considered when creating workflows. They are written here to in case the user wants to write their own workflows and doesn't know where to start...
#### 1. Job Based Workflow Structure

Workflows are split into distinct jobs (e.g., Setup, Test, Linting, Docker Build), each representing a logical unit of work. 

* **Dependency Control**: Jobs can be configured to run only if prerequisite jobs succeed. For example, the Docker Build job will only execute if tests pass, preventing unnecessary builds.
* **Parallel Execution**: Independent jobs (e.g., Linting and Testing) can run concurrently, reducing overall workflow duration.
* **Clear Separation of Concerns**: Each job focuses on a single responsibility, making the workflow easier to understand and maintain.

#### 2. Caching for Dependency Management

To avoid reinstalling dependencies on every run, workflows uses caching mechanisms.

* **Speed Optimisation**: Cached dependencies significantly reduce setup time, especially in large projects with many packages.

#### 3. Matrix Builds for Parallelisation
Matrix variables are used to run multiple instances of a job (Docker Build) in parallel with differnt inputs. 

* **Speed Optimisation**: Reduces total build time

#### 4. Composite Actions for Modularity

Reusable composite actions are defined in .github/actions, encapsulating common sequences of steps:

* **Encapsulation**: Complex logic is abstracted into their own action.yaml files, improving readability in the main workflow file.
* **Reusability**: These actions can be reused across multiple workflows or repositories (theoretically...).
* **Maintainability**: Changes to shared logic only need to be made in one place.

#### 5. Script Abstraction for Maintainability
Where appropriate, shell scripts are abstracted into standalone .sh files (rather than defined inline in YAML) and invoked from workflows.

* **Testing**: Easier to test locally without triggering a workflow.
* **Maintainability**: Cleaner and more readable YAML & promotes reuse of scripts
