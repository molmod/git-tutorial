<!--
SPDX-FileCopyrightText: 2026 Toon Verstraelen <Toon.Verstraelen@UGent.be>
SPDX-License-Identifier: CC-BY-4.0
-->

<!-- This file is rendered from a template in handson/.template/. Edit the template instead. -->

# Basics of GitHub and Markdown (web browser only)

## Overview

This tutorial is hosted on GitHub and also serves as an example of how to organize a Git repository.

For the hands-on part, you will use the sandbox repository <https://github.ugent.be/SciCompPhys/sandbox-2026>, where you can experiment and make mistakes without consequences.
You can read the sandbox, but you cannot make changes in it directly.
Instead, you will make your own copy, a so-called **fork**, for your edits.

This tutorial runs through some essential aspects of collaborative software development:

- Basic GitHub profile settings
- Markdown formatting
- Reporting an **issue**
- Fixing this issue through a **fork** and a **pull request**

This guide is intended to be followed in a web browser, without any Git client installed on your computer.
It is recommended to follow the steps below after the presentation and the live demonstration.

## Log in

The sandbox is hosted on `github.ugent.be`, the GitHub instance of Ghent University,
which is separate from `github.com`.
Log in to <https://github.ugent.be> with your UGent account.
(This is not your `github.com` account, if you have one.)

## GitHub profile settings

Before putting any content on GitHub, open the [profile](https://github.ugent.be/settings/profile) and [email](https://github.ugent.be/settings/emails) settings.
Fill in the following fields:

- Your full name
- Your professional email address

This information is important for:

- the attribution of your contributions to a Git repository, and
- your copyrights over your contributions.

Later, when you use Git in the terminal, you will configure the same name and email address.

## Markdown

Most text on GitHub is written in Markdown, including issues, pull requests and `README.md` files.

Markdown is a set of simple rules for writing text files that can be easily rendered with some basic layout.
It is designed to be readable when opened as a text file, unlike other *markup* languages such as HTML or LaTeX, hence its name.
What you are reading now is also written in Markdown.

There are plenty of good introductory resources on Markdown:

- [Basic writing and formatting syntax on GitHub](https://docs.github.com/en/get-started/writing-on-github/getting-started-with-writing-and-formatting-on-github/basic-writing-and-formatting-syntax)
- [Markdown overview](https://www.markdownguide.org/)

You can skip them for now. Markdown is simple enough to pick up as you go.

Take a look at the file [`foods.md`](https://github.ugent.be/SciCompPhys/sandbox-2026/blob/main/foods.md) in the sandbox repository.
It has a section for each food, with a few placeholder items (`...`)
where you can explain why you like that food.
This file is written in Markdown too, which you can see by clicking on **Code**.

## Create an issue

Pick a food from [`foods.md`](https://github.ugent.be/SciCompPhys/sandbox-2026/blob/main/foods.md) that you like.
Go to the [sandbox repository](https://github.ugent.be/SciCompPhys/sandbox-2026).
Click on **Issues** and open a new issue to report that `foods.md` does not yet explain why this food is great.

- Provide a concise title, e.g., "Explain why waffles are great".

- Keep the description clear and to the point.

- Click on **Create** and write down the issue number.

You will now see the page of your new issue.
Click on **Issues** again to see it in the list, together with those of other tutorial participants.
If someone else has already picked the same food, you can still proceed,
but you may run into a conflict later on.

## Create a fork and a pull request

- Go back to the [`foods.md`](https://github.ugent.be/SciCompPhys/sandbox-2026/blob/main/foods.md) file, then click on :pencil2:.

  You are now asked to create a **fork** of the repository, which is a copy of the repository under your own account.
  Click **Fork this repository**.

- Use the web editor to replace one of the `...` placeholders in the section of your food with a short reason why you like it.
  Keep the `-` at the start of the line, so it remains a list item.
  [Have fun](https://github.com/ikatyang/emoji-cheat-sheet/blob/master/README.md)!

- After editing, click the green **Commit changes** button.

  - Write a concise commit message describing your change, e.g., "Explain why waffles are great".

  - In the **Extended description** field, explain what you changed and why.
    Include a line

    ```text
    Fixes #XYZ
    ```

    where `XYZ` is your issue number.
    This number must be prefixed with a `#` without whitespace.
    When your change is merged, GitHub recognizes this keyword and closes the issue automatically.

  - Click on **Propose changes**.

- You will now see a page comparing your changes with the sandbox, where you can open a pull request to submit them for review.
  Click on **Create pull request**.

- Check the information you entered and click on **Create pull request** again.

- In the sidebar of your pull request, under **Development**, check that your issue is listed.
  If not, the `Fixes #XYZ` line is probably not formatted correctly.
  You can fix it by editing the description of the pull request.

- Sit back and relax while your instructor tries to *merge* all pull requests.

## After the merge

Once your pull request is merged:

- Check that your issue has been closed automatically.

- Open the [commit history](https://github.ugent.be/SciCompPhys/sandbox-2026/commits/main) of the sandbox and find your commit.
  It is attributed to you, thanks to your profile settings.

If your instructor asks for changes before merging, edit `foods.md` again in your fork,
on the branch of your pull request (e.g. `patch-1`), and commit directly to that branch.
New commits on this branch are added to the pull request automatically.

## Epilogue

The [GitHub documentation](https://docs.github.com/) is an excellent resource for learning about Git and GitHub.
It provides additional background, making it easier to understand how Git works and how you can use it in your own projects.

The next step is to learn how to use Git in the terminal, which is covered in [`handson_cli.md`](handson_cli.md).
