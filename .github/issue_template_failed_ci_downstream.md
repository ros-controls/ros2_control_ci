---
title: CI build job {{ env.ACTION_NAME }} failed on downstream workspace
labels: CI
---
An automated scheduled build failed on `{{ env.REF }}`: {{ env.URL }} while building or testing the
downstream workspace. This could be the result of a change in this repo breaking things downstream
or an error caused because of downstream changes.
