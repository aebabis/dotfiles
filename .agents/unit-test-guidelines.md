# Use the following guidelines when writing tests:

- Follow clear setup, invocation, assertion structure. Setup step and invocation can be combined if it improves clarity.
- Use variable names to indicate significance of inputs

  Example:

  ```javascript
  const roomWithoutReservations = ...;
  ```

- It should be easy to verify the semantic correctness of a test by skimming it
  - A test should be no more than 1 screen tall. Ideally, it is 20 lines or fewer
  - Where reasonable, populate databases and other data sources with data declared inside the tests. Where lots of data is required, still perform the insert at the top of the test, referencing the test data.

    Example 1:

    ```javascript
    Users.insert(makeTestUser({ name: 'Fred', id: '1' }));
    ```

    Example 2:

    ```javascript
    Users.insertMany(MOCK_USERS);
    ```

  - Use factory functions with default values to construct test data
    - A casual read of the tests should not require reading helper functions to determine probable correctness. The "meat" of the test should be inside the `it` block.
  - Relevant values and properties should appear inside the tests while irrelevant values should not
  - Prefer hard-coded literals for relevant values to avoid indirection. Make test values distinct, so their significance is easy to spot

    Example 1:

    ```javascript
    Animal.insertMany([
      makeTestAnimal({ type: 'big', count: 99 }),
      makeTestAnimal({ type: 'small', count: 1000 }),
    ]);
    const result = AnimalService.queryAnimals({ type: 'big' });
    expect(result.length).toBe(1);
    expect(result[0].count).toBe(99);
    ```

    Example 2:

    ```javascript
    Restaurants.insertMany([
      makeTestRestaurant({ location: 'France', count: 30, company: 'Carrots Inc' }),
      makeTestRestaurant({ location: 'Spain', count: 100, company: 'LOVE POTATOES' }),
      makeTestRestaurant({ location: 'Spain', count: 7, company: 'Carrots Inc' }),
    ]);
    const result = RestaurantService.getCompanySummary({ company: 'Carrots Inc' });
    expect(result.numLocations).toBe(37);
    ```

  - Deviate from these guidelines when it would *substantially* reduce the size of the tests
