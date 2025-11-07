# Welcome to CITEAM

This repository is for **Cyberinfrastructure Training for Electron Microscopy–Enabled Materials Science (CITEAM)** course materials.

## Authoring content

The content in this repository is written in the form of markdown
files or Jupyter notebooks, and processed using [Quarto] in order to
generate the website.

To add/update content, do this:

- Download and install Quarto from [quarto.org][Quarto].
- Clone/fork this repository.
- Create a branch to work on, with `git checkout -b <branch-name>`.
- Add/edit content in the form of `.md`, `.qmd`, or `.ipynb` files.
  If you need tutorials or reference material about authoring, [Quarto
  Guide][quarto-guide] is very helpful.
- Run `quarto preview` in a terminal, which will start a local web
  server with a live preview that opens in your web browser.
- Once you are satisfied with your changes, commit them, push the
  branch to GitHub, and submit a pull request.  A project member will
  eventually review and merge the PR.

Once content is in the `main` branch of this GitHub repository, the
[publish] workflow should take care of the building and publishing the
site.