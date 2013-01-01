<?php

class TestRPNSolver extends UnitTestCase {
  function testAddition() {
    $this->assertEqual(RPNSolver("+ 2 10"), 12, 
                       "Addition + 2 10 should be solved as 12");
  }

  function testSubstraction() {
    $this->assertEqual(RPNSolver("- 20 3"), 17,
                       "Substraction - 20 3 should be solved as 17");

  }

  function testMultiplication() {
    $this->assertEqual(RPNSolver("* 4 100"), 400,
                       "Multiplication * 4 100 should be solved as 400");

  }

  function testDividing1() {
    $this->assertEqual(RPNSolver("/ 300 10"), 30,
                       "Dividing / 300 10 should be solved as 30");

  }

  function testDividing2() {
    $this->assertEqual(RPNSolver("/ 1 0"), "Arithmetic error",
                       "Dividing / 1 0 (by zero) must raise error");

  }

  function testValidInput1() {
    $this->assertEqual(RPNSolver("* + 4 5 6"), 54,
                       "* + 4 5 6 should be solved as 54");

  }

  function testValidInput2() {
    $this->assertEqual(RPNSolver("/ - 11 1 5"), 2,
                       "/ - 11 1 5 should be solved as 2");

  }

  function testSingleInt1() {
    $this->assertEqual(RPNSolver("1"), 1,
                       "input with only one integer (1) "
                       . "should be solved as 1");

  }

  function testSingleInt2() {
    $this->assertEqual(RPNSolver("20"), 20,
                       "input with only one integer (20) "
                       . "should be solved as 20");

  }

  function testInvalidOperandNumber1() {
    $this->assertEqual(RPNSolver("+ 1"),
                       "Invalid operand number",
                       "invalid operand number + 1 should raise error");

  }

  function testInvalidOperandNumber2() {
    $this->assertEqual(RPNSolver("* - 5 6"),
                       "Invalid operand number",
                       "invalid operand number * - 5 6 should raise error");

  }

  function testOnlyOps1() {
    $this->assertEqual(RPNSolver("+"),
                       "No operand found",
                       "input + with only operation should raise error");

  }

  function testOnlyOps2() {
    $this->assertEqual(RPNSolver("- /"),
                       "No operand found",
                       "input - / with only operation should raise error");

  }

  function testInvalidChar1() {
    $this->assertEqual(RPNSolver("+ % 1"), "Invalid input: %",
                       "input + % 1 with invalid character(s) "
                       . "should raise error");

  }

  function testInvalidChar2() {
    $this->assertEqual(RPNSolver("/ 2_ 1"), "Invalid input: 2_",
                       "input / 2_ 1 with invalid character(s) "
                       . "should raise error");

  }

  function testUnsplittedOps() {
    $this->assertEqual(RPNSolver("+- 1 2 3"), "Invalid input: +-",
                       "input +- 1 2 3 with unsplitted operations "
                       . "should raise error");

  }

  function testEmpty() {
    $this->assertEqual(RPNSolver(""), "Invalid input: ",
                       "empty input should raise error");

  }

  function testSpaceOnly() {
    $this->assertEqual(RPNSolver("  "), "No operand found",
                       "space-only input should raise error");

  }
}
