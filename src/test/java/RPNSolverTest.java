package codex;

import junit.framework.TestSuite;
import junit.framework.TestCase;
import junit.framework.Test;

import static junit.framework.Assert.*;
import static codex.RPNSolver.solve;

/**
 * Tests for Reverse Polish Notation solver.
 */
public final class RPNSolverTest extends TestCase {
    public RPNSolverTest(String name) {
        super(name);
    }

    public static Test suite() {
        final TestSuite suite = new TestSuite();
        
        suite.addTest(new RPNSolverTest("addition"));
        suite.addTest(new RPNSolverTest("substraction"));
        suite.addTest(new RPNSolverTest("multiplication"));
        suite.addTest(new RPNSolverTest("dividing"));
        suite.addTest(new RPNSolverTest("dividingByZero"));
        suite.addTest(new RPNSolverTest("complex1"));
        suite.addTest(new RPNSolverTest("complex2"));
        suite.addTest(new RPNSolverTest("singleInt1"));
        suite.addTest(new RPNSolverTest("singleInt2"));
        suite.addTest(new RPNSolverTest("invalidOperandNum1"));
        suite.addTest(new RPNSolverTest("invalidOperandNum2"));
        suite.addTest(new RPNSolverTest("onlyOp1"));
        suite.addTest(new RPNSolverTest("onlyOp2"));
        suite.addTest(new RPNSolverTest("invalidChar1"));
        suite.addTest(new RPNSolverTest("invalidChar2"));
        suite.addTest(new RPNSolverTest("unsplitted"));
        suite.addTest(new RPNSolverTest("empty"));
        suite.addTest(new RPNSolverTest("spaceOnly"));
        
        return suite;
    } // end of suite

    // ---

    public void addition() {
        assertEquals("solve + 2 10 as 12",
                     solve("+ 2 10"), 12);

    }

    public void substraction() {
        assertEquals("solve - 20 3 as 17",
                     solve("- 20 3"), 17);

    }

    public void multiplication() {
        assertEquals("solve * 4 100 as 400",
                     solve("* 4 100"), 400);

    }

    public void dividing() {
        assertEquals("solve / 300 10 as 30",
                     solve("/ 300 10"), 30);
    }

    public void dividingByZero() {
        try {
            solve("/ 1 0");

            fail("should raise error for / 1 0");
        } catch (Throwable t) {
            assertEquals("Unexpected error message",
                         t.getMessage(), "Arithmetic error");

        }
    }

    public void complex1() {
        assertEquals("solve * + 4 5 6 as 54",
                     solve("* + 4 5 6"), 54);

    }

    public void complex2() {
        assertEquals("solve / - 11 1 5 as 2",
                     solve("/ - 11 1 5"), 2);

    }

    public void singleInt1() {
        assertEquals("input with only one integer 1 should be solved as 1",
                     solve("1"), 1);
    }

    public void singleInt2() {
        assertEquals("input with only one integer 20 should be solved as 20",
                     solve("20"), 20);
    }

    public void invalidOperandNum1() {
        try {
            solve("+ 1");

            fail("invalid operand number should raise error for + 1");
        } catch (Throwable t) {
            assertEquals("Unexpected error message", 
                         t.getMessage(), "Invalid operand number");

        }
    }

    public void invalidOperandNum2() {
        try {
            solve("* - 5 6");

            fail("invalid operand number should raise error for * - 5 6");
        } catch (Throwable t) {
            assertEquals("Unexpected error message", 
                         t.getMessage(), "Invalid operand number");

        }
    }

    public void onlyOp1() {
        try {
            solve("+");

            fail("input with only operation + should raise error");
        } catch (Throwable t) {
            assertEquals("Unexpected error message",
                         t.getMessage(), "No operand found");
        }
    }

    public void onlyOp2() {
        try {
            solve("- /");

            fail("input with only operations - / should raise error");
        } catch (Throwable t) {
            assertEquals("Unexpected error message",
                         t.getMessage(), "No operand found");
        }
    }

    public void invalidChar1() {
        try {
            solve("+ % 1");

            fail("input with invalid character(s) " 
                 + "should raise error for + % 1");

        } catch (Throwable t) {
            assertEquals("Unexpected error message", 
                         t.getMessage(), "Invalid input: %");
        }
    }

    public void invalidChar2() {
        try {
            solve("/ 2_ 1");

            fail("input with invalid character(s) " 
                 + "should raise error for / 2_ 1");

        } catch (Throwable t) {
            assertEquals("Unexpected error message", 
                         t.getMessage(), "Invalid input: %");
        }
    }

    public void unsplitted() {
        try {
            solve("+- 1 2 3");

            fail("unsplitted operations +- 1 2 3 should raise error");
        } catch (Throwable t) {
            assertEquals("Unexpected error message",
                         t.getMessage(), "Invalid input: +-");
        }
    }

    public void empty() {
        try {
            solve("");

            fail("empty input should raise error");
        } catch (Throwable t) {
            assertEquals("Unexpected error message",
                         t.getMessage(), "Invalid input: ");

        }
    }

    public void spaceOnly() {
        try {
            solve("  ");

            fail("space-only input should raise error");
        } catch (Throwable t) {
            assertEquals("Unexpected error message",
                         t.getMessage(), "No operand found");
        }
    }
}
