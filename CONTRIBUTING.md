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


## Editing the workflow content

The toolkit ships as a single plugin, and **`plugins/product-toolchest/` is the single source of truth** — there are no parallel per-project copies to keep in sync. Edit the plugin files directly:

1. **`plugins/product-toolchest/prompts/*.md`** — the authoritative workflow guides. Make workflow-behavior changes here first.
2. **`plugins/product-toolchest/skills/*/SKILL.md` and `plugins/product-toolchest/agents/*.md`** — thin shims that *reference* the guides. Keep them thin: point at the guide via `${CLAUDE_PLUGIN_ROOT}/prompts/…`, don't copy prose into them (copied prose is where drift starts).
3. **`plugins/product-toolchest/prompts/Review_Lenses.md`** — the on-demand review-lens definitions used by `product-reviewer`.
4. **`plugins/product-toolchest/hooks/hooks.json`** — the advisory validation gate (JS syntax on `Screen_*.html`, SVG check on `PRD_*.html`).

Additional invariants:

* The two HTML templates (`plugins/product-toolchest/prompts/ProjectDashboard_Template.html`, `plugins/product-toolchest/prompts/ScreenIndex_Template.html`) are referenced by the prototype guides — keep their placeholder names in sync with the guides that fill them.
* Specific values that have drifted before and must match across the guides: research dimension names (6 of them), source-count gates (120+/150+), the 5 Logo Gate checks, the `[Type]_[Product]_[YYYY-MM-DD].html` naming convention, the ScreenIndex placeholder list, and the Design Token Contract categories.
* Hook counts and the agent/skill rosters are enumerated in `README.md` and `plugins/product-toolchest/README.md` — update both when you add or remove a hook, agent, or skill.

A quick way to check for drift after an edit: `grep -rn "<the value you changed>" plugins/product-toolchest/ README.md`.


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
