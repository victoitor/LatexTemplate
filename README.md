# Finding Bramble of Constant Congestion

## Where is the PDF?

[Here](https://github.com/victoitor/<repository>/releases/download/latest/paper.pdf) is the current version of the paper.

[Here](<link>) are the images generated from the whiteboards.


# Git Workflow Guide

This document explains the typical Git workflow used in collaborative software projects, including how to:

- Clone a repository
- Create a new branch
- Open a Pull Request (PR)
- Resolve merge conflicts on a PR

---

## 1. Clone a Repository

To start working on a project, first clone the remote repository to your local machine:

```bash
git clone git@github.com:<repository>.git
cd <repository>
```

---

## 2. Create a New Branch

It’s best practice to create a new branch for each feature or bugfix:

```bash
git checkout -b my-feature-branch
```

This creates and switches to a new branch called `my-feature-branch`.

---

## 3. Work, Commit, and Push

Make your changes locally, then stage and commit them:

```bash
git add .
git commit -m "Add feature XYZ"
```

Push your branch to the remote repository:

```bash
git push origin my-feature-branch
```

---

## 4. Open a Pull Request (PR)

Go to the repository on GitHub. You’ll usually see a prompt to open a Pull Request for your pushed branch. If not, navigate to the **Pull Requests** tab and click **New pull request**.

- Choose your branch as the source
- Choose the target branch (often `main`)
- Add a descriptive title and detailed description
- Submit the PR for review

---

## 5. Resolving Merge Conflicts

If your PR cannot be merged automatically due to conflicts, follow these steps:

### a. Fetch latest changes from the target branch

```bash
git fetch origin
git checkout my-feature-branch
git merge origin/main
```

(or replace `main` with the target branch name)

### b. Resolve conflicts manually

Git will mark conflicts in the files. Open the conflicting files and look for sections like:

```diff
<<<<<<< HEAD
Your changes
=======
Incoming changes from main
>>>>>>> main
```

Edit the file to keep the desired code, then remove the conflict markers (`<<<<<<<`, `=======`, `>>>>>>>`).

### c. Stage and commit the resolved files

```bash
git add <file1> <file2> ...
git commit -m "Resolve merge conflicts"
```

### d. Push the updated branch

```bash
git push origin my-feature-branch
```

The PR will update automatically.

---

## Summary

```bash
# Clone repository
git clone git@github.com:victoitor/ConstantCongestionBramble.git
cd ConstantCongestionBramble

# Create and switch to a new branch
git checkout -b my-feature-branch

# Work, commit, and push
git add .
git commit -m "Description"
git push origin my-feature-branch

# Update branch with target branch changes (for conflicts)
git fetch origin
git merge origin/main

# Resolve conflicts, commit, and push again
git add <resolved files>
git commit -m "Resolve merge conflicts"
git push origin my-feature-branch
```
