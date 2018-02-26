# Content Purpose Supergroups

These are the grouping that the navigation team came up with
as a result of an investigation done using the "Jobs to be Done" framework in Q4.

There are 5 high level Content Purpose Supergroups which each group together some subgroups
which in turn group `document_types`.

More information about the JTBD framework and the supergroups can be found on the
[GovUK wiki](https://gov-uk.atlassian.net/wiki/spaces/GFED/pages/305201156/Document+type+groupings)

The list of which document types are grouped by both supergroups and subgroups can be
found in the [supertypes.yml](./supertypes.yml) file.

The list of the subgroups grouped by supergroup are in the file [supergroups.yml](./supergroups.yml).
If you want to make a change to the `document_type` groupings in the sub or supergroups, you must make the
relevant change in both groups and both files to make sure there are no discrepancies between the groups.

To make sure that your changes were correct, run the data linting test in the
[data_lint_spec.rb](../spec/data_lint_spec.rb) file. 