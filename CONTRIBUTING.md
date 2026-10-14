# Contributing Guidelines

Thank you for your interest in contributing to our project. Whether it's a bug report, new feature, correction, or additional
documentation, we greatly value feedback and contributions from our community.

Please read through this document before submitting any issues or pull requests to ensure we have all the necessary
information to effectively respond to your bug report or contribution.


## Reporting Bugs/Feature Requests

We welcome you to use the GitHub issue tracker to report bugs or suggest features.

When filing an issue, please check existing open, or recently closed, issues to make sure somebody else hasn't already
reported the issue. Please try to include as much information as you can. Details like these are incredibly useful:

* A reproducible test case or series of steps
* The version of our code being used
* Any modifications you've made relevant to the bug
* Anything unusual about your environment or deployment


## Contributing via Pull Requests
Contributions via pull requests are much appreciated. Before sending us a pull request, please ensure that:

1. You are working against the latest source on the *main* branch.
2. You check existing open, and recently merged, pull requests to make sure someone else hasn't addressed the problem already.
3. You open an issue to discuss any significant work - we would hate for your time to be wasted.

To send us a pull request, please:

1. Fork the repository.
2. Modify the source; please focus on the specific change you are contributing. If you also reformat all the code, it will be hard for us to focus on your change.
3. Ensure local tests pass.
4. Commit to your fork using clear commit messages.
5. Send us a pull request, answering any default questions in the pull request interface.
6. Pay attention to any automated CI failures reported in the pull request, and stay involved in the conversation.

GitHub provides additional document on [forking a repository](https://help.github.com/articles/fork-a-repo/) and
[creating a pull request](https://help.github.com/articles/creating-a-pull-request/).


## Editing the workflow content (layering rule)

This toolkit runs in multiple AI assistants, so the same guidance exists in several layers. **`prompts/*.md` is the single source of truth.** When you change workflow behavior, update the layers in this order and keep them consistent:

1. **`prompts/*.md`** — the authoritative guides. Make the change here first.
2. **`.kiro/steering/*.md`** — Kiro mirrors of the same guidance. Reconcile any numeric values, phase names, file-naming rules, and checklists with the prompts.
3. **`.claude/agents/*.md` and `.claude/skills/*/SKILL.md`** — thin shims that *reference* the prompts. Keep them thin: point at the guide, don't copy prose into them (copied prose is where drift starts).
4. **`CLAUDE.md` and `.cursorrules`** — the always-loaded summaries for Claude Code and Cursor. These intentionally duplicate key rules (dashboard protocol, Logo Gate, build order); if you change one of those rules, update both files in the same PR.
5. **The portable plugin (`plugin.json` + `skills/`)** — the cross-editor Agent Plugin at the repo root. Each skill's `references/*.md` are copies of the corresponding `prompts/*.md` guide (plus `skills/product-research/references/Brand_And_Logo_Rules.md`, extracted from `CLAUDE.md`). When you change a guide in `prompts/`, refresh the matching copy under `skills/<name>/references/`. Keep each `SKILL.md` thin — role, non-negotiables, and a reference table that points at the bundled guides via skill-relative paths (no `prompts/` paths, no client-specific variables).

Additional invariants:

* The templates duplicated at `prompts/ProjectDashboard_Template.html` / `prompts/ScreenIndex_Template.html` and `.kiro/steering/templates/` **must stay byte-identical** — `diff` them before committing.
* Specific values that have drifted before and must match everywhere: research dimension names (6 of them), source-count gates (120+/150+), the 5 Logo Gate checks, the `[Type]_[Product]_[YYYY-MM-DD].html` naming convention, the ScreenIndex placeholder list, and the Design Token Contract categories.
* Hook counts and agent/skill rosters are enumerated in `README.md`, `CLAUDE.md`, and `Getting_Started_Guide.html` — update the counts when you add or remove a hook, agent, or skill.

A quick way to check for drift after an edit: `grep -rn "<the value you changed>" prompts/ .kiro/ .claude/ CLAUDE.md .cursorrules README.md Getting_Started_Guide.html`.


## Finding contributions to work on
Looking at the existing issues is a great way to find something to contribute on. As our projects, by default, use the default GitHub issue labels (enhancement/bug/duplicate/help wanted/invalid/question/wontfix), looking at any 'help wanted' issues is a great place to start.


## Code of Conduct
This project has adopted the [Amazon Open Source Code of Conduct](https://aws.github.io/code-of-conduct).
For more information see the [Code of Conduct FAQ](https://aws.github.io/code-of-conduct-faq) or contact
opensource-codeofconduct@amazon.com with any additional questions or comments.


## Security issue notifications
If you discover a potential security issue in this project we ask that you notify AWS/Amazon Security via our [vulnerability reporting page](http://aws.amazon.com/security/vulnerability-reporting/). Please do **not** create a public github issue.


## Licensing

See the [LICENSE](LICENSE) file for our project's licensing. We will ask you to confirm the licensing of your contribution.
