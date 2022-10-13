--We previously set the default values of these columns to 2, so we're reseting them to 0 now, before users begin the real checklist.

UPDATE college_checklist
SET
	app_deadline = NULL,
	app_completion = 0,
	app_review = 0,
	app_submission = NULL,
	fee_payment = 0,
	transcript_submission = 0,
	test_submission = 0,
	essay_submission = 0,
	recommendation_submission = 0,
	fafsa_submission = 0,
	result = 0,
	choice = 0;