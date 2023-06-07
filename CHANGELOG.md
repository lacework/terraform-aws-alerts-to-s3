# v0.4.1

## Bug Fixes
* fix: S3 bucket ACL dependency (jon-stewart)([bb785cb](https://github.com/lacework/terraform-aws-alerts-to-s3/commit/bb785cbdda412ee0e6efafef00953968845d525a))
## Other Changes
* ci: version bump to v0.4.1-dev (Lacework)([92b7f14](https://github.com/lacework/terraform-aws-alerts-to-s3/commit/92b7f14f9f0962d67cd051643440575a3944ea8a))
---
# v0.4.0

## Features
* feat: Add support for AWS provider 5.0 (#8) (Darren)([3c21628](https://github.com/lacework/terraform-aws-alerts-to-s3/commit/3c21628596b031f96bfcbd4c09bc010be1ce9cab))
## Other Changes
* ci: version bump to v0.3.2-dev (Lacework)([69fbe9e](https://github.com/lacework/terraform-aws-alerts-to-s3/commit/69fbe9edaddbb82e50318797779e90f008789166))
---
# v0.3.1

## Bug Fixes
* fix: s3 bucket ownership controls (#5) (djmctavish)([3c12b94](https://github.com/lacework/terraform-aws-alerts-to-s3/commit/3c12b94099ff3e65dae8e3c375b2c1a01e4ed6c5))
## Other Changes
* ci: version bump to v0.3.1-dev (Lacework)([1467053](https://github.com/lacework/terraform-aws-alerts-to-s3/commit/14670536d0f47fd1c2c106c113d2453f178eb9f5))
---
# v0.3.0

## Features
* feat: add examples to examples/default (Daniel Fitzgerald)([50e51fa](https://github.com/lacework/terraform-aws-alerts-to-s3/commit/50e51fa10320e66657774e301dbd1062a1d61d04))
## Bug Fixes
* fix: incorrect path reference to index.js file (Daniel Fitzgerald)([9dde983](https://github.com/lacework/terraform-aws-alerts-to-s3/commit/9dde98397e82f0d2af142d9e0bcf0f2f9f5f6889))
* fix: removed unnecessary lacework and aws provider blocks from versions.tf, removed unnecessary variables aws.region and aws.profile (Daniel Fitzgerald)([5caf77c](https://github.com/lacework/terraform-aws-alerts-to-s3/commit/5caf77c98e939a9da8199bc071b76686691940b9))
## Other Changes
* ci: version bump to v0.2.1-dev (Lacework)([91d5127](https://github.com/lacework/terraform-aws-alerts-to-s3/commit/91d512723a28e7c4e89c4cd566806794babdf810))
---
# v0.2.0

## Features
* feat: shape our TF module scaffolding (#1) (matthew zeier)([bc307ea](https://github.com/lacework/terraform-aws-alerts-to-s3/commit/bc307ea95adc23e45eb076d2d65d8f4f3c0fc840))
## Refactor
* refactor: delete unused scaffold files in favour of those in terraform/ dir (Daniel Fitzgerald)([0792fe6](https://github.com/lacework/terraform-aws-alerts-to-s3/commit/0792fe6ab776f91f6631e6f996e7e4a245abf70b))
## Bug Fixes
* fix: replaced the correct project name in scripts/release.sh (Daniel Fitzgerald)([20e4abb](https://github.com/lacework/terraform-aws-alerts-to-s3/commit/20e4abb47d861ad53480e8869a310f588e82a4f7))
* fix: make eventbridge alert channel name more descriptive (Daniel Fitzgerald)([900e2b6](https://github.com/lacework/terraform-aws-alerts-to-s3/commit/900e2b6bbab830f0db7f88de2c66b7f7c48c6ed5))
* fix: updated project_name in ci_tests script (Daniel Fitzgerald)([76e1ac7](https://github.com/lacework/terraform-aws-alerts-to-s3/commit/76e1ac77d8d6c2edc2bdb192e186bb2dae68777c))
## Documentation Updates
* docs: added links to configure lw cli in prereqs (Daniel Fitzgerald)([6487f8d](https://github.com/lacework/terraform-aws-alerts-to-s3/commit/6487f8d426cee196fa5b6f42c5d6aee5fb624471))
* docs: add emphasis to the need for an alert rule (Daniel Fitzgerald)([bd36325](https://github.com/lacework/terraform-aws-alerts-to-s3/commit/bd363253bf99090ec50229e508b658d745be8bfa))
* docs: updated module inputs/outputs (Daniel Fitzgerald)([bdd29fd](https://github.com/lacework/terraform-aws-alerts-to-s3/commit/bdd29fd6793200d3bba6c5db42c4bec4ab03be2d))
## Other Changes
* chore: do not want to commit terraform lock file (Daniel Fitzgerald)([c3cc4ce](https://github.com/lacework/terraform-aws-alerts-to-s3/commit/c3cc4ced2348b9503d6a236169c72d5d0f5e0f27))
* chore(scaffolding): Update pull-request-template.md to latest (Ross)([b0ff70b](https://github.com/lacework/terraform-aws-alerts-to-s3/commit/b0ff70b5b5a60ff01ff1a268bbd3b876d3087f65))
* chore(scaffolding): Add .github config (Ross)([c8fdbfa](https://github.com/lacework/terraform-aws-alerts-to-s3/commit/c8fdbfa9199ad0778dc1b1b3c94d72d775196117))
* chore(scaffolding): Update scaffolding repo (Ross)([6afb32d](https://github.com/lacework/terraform-aws-alerts-to-s3/commit/6afb32d87dfa1bdd3622e36ec706c9b1cf40c568))
* chore: bump required version of TF to 0.12.31 (#3) (Scott Ford)([8057fa2](https://github.com/lacework/terraform-aws-alerts-to-s3/commit/8057fa22c45ff3761aeda581a8ccd927d67a6b11))
* ci: sign lacework-releng commits (#4) (Salim Afiune)([4e7acfd](https://github.com/lacework/terraform-aws-alerts-to-s3/commit/4e7acfdf05242de9da8e7144cb6c292a68eaa1e1))
* ci: fix finding major versions during release (#2) (Salim Afiune)([3708e8d](https://github.com/lacework/terraform-aws-alerts-to-s3/commit/3708e8dde60977c7566a1e0528266912067919f6))
---
