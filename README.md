# lab-image-creation
This GitHub Actions workflow file automates the process of incrementing versions and building Docker images for different environments (development, UAT, and production) when there is a pull request to the `dev`, `uat`, or `prod` branches. Here is the documentation for the workflow:

### Workflow Name
**build lab manual trigger**

### Triggers
- This workflow runs on pull requests targeting the `dev`, `uat`, or `prod` branches.

### Jobs
#### build
- **runs-on**: `ubuntu-latest`

##### Environment Variables
- `ACTIONS_ALLOW_UNSECURE_COMMANDS`: true
- `ACR_SERVER_NAME_DEV`: `${{ secrets.REGISTRY_LOGIN_SERVER }}`
- `ACR_SERVER_NAME_UAT`: `${{ secrets.REGISTRY_LOGIN_SERVER }}`
- `ACR_SERVER_NAME_PROD`: `${{ secrets.REGISTRY_LOGIN_SERVER_PROD }}`

##### Steps
1. **Checkout Repository**
    - Uses: `actions/checkout@v4`
    - Fetches the entire history (`fetch-depth: '0'`).

2. **Find Changed Files in Subfolders**
    - ID: `find-dockerfiles`
    - Runs a shell script to identify which subfolders under `labs/` have changes in the latest commit.

3. **Increment Versions**
    - Increments the version in `Details.yaml` files based on commit messages containing keywords like "major", "minor", or "patch".
    - Uses an external script `increment_version.sh` for version incrementing.

4. **Commit and Push Changes**
    - Configures Git with user name and email from secrets.
    - Commits and pushes the changes if there are any.

5. **Build Docker Images in Changed Folders (Development)**
    - ID: `dev-build`
    - Conditional: Only runs if the branch is `dev`.
    - Builds and pushes Docker images to the development Azure Container Registry (`$ACR_SERVER_NAME_DEV`).

6. **Build Docker Images in Changed Folders (UAT)**
    - ID: `uat-build`
    - Conditional: Only runs if the branch is `uat`.
    - Builds and pushes Docker images to the UAT Azure Container Registry (`$ACR_SERVER_NAME_UAT`).

7. **Build Docker Images in Changed Folders (Production)**
    - ID: `prod-build`
    - Conditional: Only runs if the branch is `prod`.
    - Builds and pushes Docker images to the production Azure Container Registry (`$ACR_SERVER_NAME_PROD`).

### Key Points
- The workflow supports versioning based on commit messages.
- It includes automated Docker builds and pushes for different environments.
- Environment-specific Azure Container Registry credentials and server names are managed using GitHub secrets.
- The workflow ensures that only relevant subfolders are processed, improving efficiency.

This setup facilitates continuous integration and continuous deployment (CI/CD) for lab environments, ensuring that any changes to the `labs/` directory are properly versioned and deployed across different stages.
