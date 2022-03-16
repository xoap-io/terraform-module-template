# PR Checklist

Use the check list below to ensure your branch is ready for PR.

- You have updated the documentation accordingly
- You have added tests to cover your changes
- All new and existing tests passed
- Your code follows the code style guidlines of this project
- You ran lint checks locally
- You checked to ensure there aren't other open Pull Requests for the same change?

## Summary

Please create a detailed description of the feature, fix or that is being added

- Provide the justifications for the changes (e.g. business case).
- Describe why these changes were made (e.g. why do these commits fix the problem?)
- Use bullet points to be concise and to the point.

### Example

#### What?

I've added support for authentication to implement Key Result 2 of OKR1. It includes
model, table, controller and test. For more background, see ticket #AZD-123.

#### Why?

These changes complete the user login and account creation experience.
See #AZD-123 for more information.

#### How?

This includes a migration, model and controller for user authentication. I'm using Devise to do the heavy lifting. I ran Devise migrations and those are included here.

## Testing

Please add detailed instructions for testing and validation of your code. Are there any prerequisites a tester must take care of?

## Description

Please add a short description of the changes introduced by your change. If you cahnged UI sepcific things please attach screenshots.

### Documentation

Where can the documentation for the new feature be found?

- Update any references for the documentation.
- Create a stub for documentation including bullet points for how to use the feature with code snippets and everything else that is needed to create a full documentation

Important: Did you make any backward incompatible changes? If yes, then you must write a migration guide!

## TODOs

Ensure all of these TODOs are completed before asking for a review.

- Ensure the branch is named correctly with the issue number (see developer guidelines for guidance)
- Update the documentation
- Keep the changes backward compatible where possible
- Run the pre-commit checks until everything passes successfully
- Run the relevant tests until everything runs successfully

## Related Issues

Link to any supporting GitHub issues or helpful documentation to add some context (e.g. stackoverflow).
