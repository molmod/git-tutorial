<!--
SPDX-FileCopyrightText: © 2026 Toon Verstraelen <Toon.Verstraelen@UGent.be>
SPDX-License-Identifier: CC-BY-4.0
-->

# Basics of Git and Markdown (web browser only)

## Overview

This tutorial is hosted on GitHub and also serves as an example of how to organize a Git repository.

For the hands-on part, we will use another private sandbox repository, <https://github.com/molmod/sandbox>, where you can experiment and make mistakes without consequences.
(Participants of the tutorial have read access.)

This section runs through some essential aspects of collaborative software development:

- Basic GitHub profile settings
- Markdown formatting
- Reporting an **Issue**
- Fixing this issue through a **Fork** and a **Pull request**.

This guide is intended to be followed in a web browser, without any Git client installed on your computer.
It is recommended to follow the steps below after the presentation and the live demonstration.

## GitHub profile settings

Before putting any content on GitHub, open the [profile](https://github.com/settings/profile) and [email](https://github.com/settings/emails) settings.
Fill in the following fields:

- Your full name
- Your professional email address

Entering this information is important:

- Attribution of your contributions to a Git repository.
- Your copyrights over your contributions.

## Markdown

Most text on GitHub is written in Markdown.
It is also used for messages in Issues and Pull requests, for `README.md` files, etc.

Markdown is a set of simple rules for writing text files that can be easily rendered with some basic layout.
It is designed to be readable when opened as a text file, unlike *markup* languages like HTML or LaTeX, hence its name.
What you are reading now is also written in Markdown.

Most text in this course is written in Markdown, either in standalone Markdown files, or inside so-called Markdown cells in Jupyter notebooks.
While Markdown is not strictly tied to Git, the GitHub platform has excellent support for Markdown.

There are plenty of good introductory resources on Markdown:

- [GitHub Markdown practical guide](https://guides.github.com/features/mastering-markdown/).
- [Markdown overview](https://www.markdownguide.org/)

There is no need to learn the details now. You'll pick it up as you go along.

Take a look at the file `participants.md` in the sandbox repository, which contains a list of the tutorial participants.
This file is written in Markdown, which can be shown by clicking on "code".

## Create an Issue

Click on **Issues** and open a new issue to report that your favorite food is missing in `participants.md` in the sandbox repository.

- Provide a concise title.

- Keep the description clear and to the point.

- Click on **Submit new issue** and write down the issue number.

You should see your issue in the list of issues, together with those of other tutorial participants.

## Create a Fork and a Pull request

- Go back to the `participants.md` file, then click on :pencil2:.
  You are now asked to create a "fork" of the repository, which is a copy of the repository under your own account.
  Click **Fork this repository**.

- Use the web editor to add your favorite food item under your name.
  [Have fun](https://github.com/ikatyang/emoji-cheat-sheet/blob/master/README.md)!

- After editing, click the green **Commit changes** button.

  - Copilot may write a commit message for you. If not, write a concise message describing your change, e.g., "Add favorite food for [your name]".

  - In the description, explain what you changed and why.
    Include a line `Fixes #XYZ`, where `XYZ` is your issue number.
    This number must be prefixed with a `#` without whitespace.

  - Click on **Propose changes**.

- You will now see a "pull request" page, which shows the changes you made and allows you to submit them for review.
  Click on **Create pull request**.

- Check the information you entered and click on **Create pull request** again.

- Sit back and relax while your instructor tries to *merge* all pull requests.

## Epilogue

The [GitHub documentation](https://docs.github.com/) is an excellent resource for learning about Git and GitHub.
It provides additional background, making it easier to understand how Git works and how it can be used in this course.

The next step is to learn how to use Git in the terminal, which is covered in [`handson_cli.md`](handson_cli.md).
