---

### 2. Create `CodeBook.md`

Copy this text into a new file named `CodeBook.md` in your project folder:

```markdown
# Code Book

## Dataset Description

The dataset contains wearable computing data collected from Samsung Galaxy S smartphones, capturing 30 subjects performing six activities. Measurements include accelerometer and gyroscope signals, and their mean and standard deviation values.

## Variables

- `subject`: Identifier of the subject (1–30)
- `activity`: Activity label (e.g., WALKING, SITTING)
- Measurement columns: Variables representing the mean and standard deviation of various signals, named descriptively, e.g.,
  - `time_BodyAccelerometer_mean_X`
  - `frequency_BodyGyroscope_std_Z`
  - etc.

## Transformations Applied

- Combined training and test datasets
- Extracted only mean and standard deviation variables (columns with `mean()` or `std()`)
- Replaced activity IDs with descriptive activity names
- Cleaned variable names to be more readable (removed parentheses, replaced abbreviations)
- Created a tidy dataset with the average of each variable grouped by subject and activity

## Notes

- The dataset `tidy_data.txt` contains the final tidy data.
- This tidy data is suitable for further analysis or modeling.