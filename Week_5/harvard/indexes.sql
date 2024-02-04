CREATE INDEX "semester_2023_2024"
ON "courses"("semester")
WHERE "semester" IN ('Fall 2024', 'Spring 2024', 'Fall 2023');

CREATE INDEX "courses_dept"
ON "courses"("department");

CREATE INDEX "course_title"
ON "courses"("title");

CREATE INDEX "enrollment_student"
ON "enrollments"("course_id");
