name: test-setup
description: Scaffold test framework for the project — determine engine-appropriate test runner (GUT for Godot, Unity Test Framework, Unreal Automation), create test directory structure (unit/integration/performance/helpers), configure test runner, write first smoke test to confirm framework works. Documents test naming conventions and coverage expectations.
allowed-tools: read_file, write_file, terminal, clarify, search_files
model: sonnet
agent: qa-lead

Test Setup — Test Framework Scaffolding

Sets up the project's test infrastructure: tool selection, directory structure, configuration, and a first passing smoke test. Without this, no automated testing can happen.

Output: tests/ directory structure, working smoke test, test conventions doc

---

Phase 1: Determine Test Framework

Read docs/technical-preferences.md for engine and language.

Engine → Default test framework:
- Godot + GDScript → GUT (Godot Unit Test)
- Godot + C# → NUnit via .NET test runner
- Unity → Unity Test Framework (built-in)
- Unreal → Unreal Automation System (built-in)

Ask the user: "Any preference for test framework?"
If no: use the engine default.
If yes: accept the user's choice.

---

Phase 2: Create Directory Structure

Create:
tests/
├── unit/           # Unit tests — isolated logic, no external dependencies
├── integration/    # Integration tests — multiple systems working together
├── performance/    # Performance tests — frame time, memory, load speed
└── helpers/        # Test utilities, mock objects, fixtures

If the engine has a specific convention (e.g., Unity expects tests in a specific folder with .asmdef): follow engine convention.

---

Phase 3: Configure Test Runner

Godot + GUT:
- Check if GUT is installed (plugin or addon): search_files(pattern='gut', path='.')
- If not: "GUT isn't detected. Install it from the AssetLib or add it to project.godot's plugins."
- Create gut.cfg or configure via editor settings
- Write a test helper: tests/helpers/test_setup.gd with common test utilities (create_test_scene, assert_approx_equal)

Unity:
- Ensure Unity Test Framework package is installed
- Create test assembly definition (.asmdef) with test references
- Ensure test assemblies reference the code under test

Unreal:
- Ensure Automation system is enabled in Build.cs
- Create functional test maps if needed

---

Phase 4: Write First Smoke Test

The smoke test must:
1. Be the simplest possible test
2. Pass on first run (confirming the test framework works)
3. Serve as a template for future tests

Godot/GUT example (tests/unit/test_smoke.gd):
```gdscript
extends GutTest
func test_smoke():
    assert_true(true, "Test framework is working")
```

Unity example (Tests/PlayMode/SmokeTest.cs):
```csharp
using UnityEngine;
using UnityEngine.TestTools;
using NUnit.Framework;
using System.Collections;
public class SmokeTest {
    [Test]
    public void TestFrameworkWorks() {
        Assert.IsTrue(true);
    }
}
```

Write the smoke test file. Ask before writing.

---

Phase 5: Verify Framework Runs

Run the test framework once:
- Godot/GUT: terminal("[godot] --headless --test")
- Unity: terminal("[unity] -runTests -testPlatform PlayMode -testFilter SmokeTest")
- Unreal: terminal("[editor] -RunTests SmokeTest")

If the framework runs and the smoke test passes: "Test framework is working. Smoke test passes."
If the framework fails to run: investigate the error. Missing plugin? Wrong path? Config issue?

---

Phase 6: Document Conventions

Write to docs/testing-standards.md (or update existing):

```
# Testing Standards

## Framework
[engine] + [test framework]

## Naming
- Test files: test_[system]_[behavior].gd (or Test_[System]_[Behavior].cs)
- Test functions: test_[behavior] (or [Behavior]_Correctly)

## Coverage Targets
- Gameplay logic: 90%+
- Engine code: 80%+
- UI: Manual verification (automated where practical)
- Critical paths (save/load, core loop): 100%

## Test Types
- Unit: Isolated functions, mocked dependencies
- Integration: Real system interactions
- Performance: Frame time, memory, load speed benchmarks
- Smoke: Game boots and runs

## Conventions
- One test file per system
- One test function per behavior/edge case
- Arrange → Act → Assert pattern
- No test depends on another test (independent execution)
```

---

Phase 7: Post-Checks

- Smoke test passes (test framework is configured correctly)
- Directory structure exists (unit, integration, performance, helpers)
- Conventions documented
- Ask: "Ready to start writing real tests. Would you like to create tests for your first system?"

---

Phase 8: Test Naming and Organization Standards

Define conventions:
- One test file per source file (mirror the src/ structure in tests/)
- One test function per behavior (not per function — test behaviors, not methods)
- Group related tests in describe blocks or test suites
- Test names should describe the scenario and expected outcome:
  Good: "test_water_plant_increases_growth_stage"
  Bad: "test_watering"

---

Phase 9: First Real Test

After the smoke test passes:
- Pick the simplest game system from systems-index.md
- Write one real test for its core behavior
- Example: if DayManager exists, test: "absence_days correctly calculates difference between dates"
- Run it: does it pass? If not, the code may have a bug (good catch!)
- "Wrote the first real test for [system]. It [passes/fails]. Ready for more."

---

Phase 10: CI Integration Notes

If the project uses CI:
- "Add this command to your CI pipeline to run tests automatically: [command]"
- "Tests run on every push. Broken builds are caught immediately."
- "For Godot: godot --headless --test in CI" 
- "For Unity: unity -runTests in CI"

If no CI is set up: "Tests can run locally. Set up CI when you're ready for automated testing."

---

Edge Cases

- Engine doesn't support testing (very old or custom): "Manual testing only. Create playtest checklists for each system."
- User doesn't want automated tests: "Tests are optional but strongly recommended. Solo mode skips the testing requirement."
- Test framework conflicts with existing project setup: "Conflict detected: [description]. Resolve before tests can run."
