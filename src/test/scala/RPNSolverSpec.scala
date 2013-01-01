package codex

import org.specs2.mutable.Specification

import codex.rpn.{ PrefixSolver }

object RPNSolverSpec extends Specification {
  "Reverse Polish Notation solver" title

  "addition" should {
    "solve + 2 10 as 12" in {
      PrefixSolver("+ 2 10") aka "result" must beRight(12)
    }
  }

  "substraction" should {
    "solve - 20 3 as 17" in {
      PrefixSolver("- 20 3") aka "result" must beRight(17)
    }
  }

  "multiplication" should {
    "solve * 4 100 as 400" in {
      PrefixSolver("* 4 100") aka "result" must beRight(400)
    }
  }

  "dividing" should {
    "solve / 300 10 as 30" in {
      PrefixSolver("/ 300 10") aka "result" must beRight(30)
    }

    "raise error for / 1 0" in {
      PrefixSolver("/ 1 0") aka "result" must beLeft("Arithmetic error")
    }
  }

  "* + 4 5 6" should {
    "be solved as 54" in {
      PrefixSolver("* + 4 5 6") aka "result" must beRight(54)
    }
  }

  "/ - 11 1 5" should {
    "be solved as 2" in {
      PrefixSolver("/ - 11 1 5") aka "result" must beRight(2)
    }
  }

  "input with only one integer" should {
    "1 should be solved as 1" in {
      PrefixSolver("1") aka "result" must beRight(1)
    }

    "20 should be solved as 20" in {
      PrefixSolver("20") aka "result" must beRight(20)
    }
  }

  "invalid operand number" should {
    "raise expected error for + 1" in {
      PrefixSolver("+ 1") aka "result" must beLeft("Invalid operand number")
    }

    "raise expected error for * - 5 6" in {
      PrefixSolver("* - 5 6") aka "result" must beLeft("Invalid operand number")
    }
  }

  "input with only operation(s)" should {
    "raise expected error for +" in {
      PrefixSolver("+") aka "result" must beLeft("No operand found")
    }

    "raise expected error for - /" in {
      PrefixSolver("- /") aka "result" must beLeft("No operand found")
    }
  }

  "input with invalid character(s)" should {
    "raise expected error for + % 1" in {
      PrefixSolver("+ % 1") aka "result" must beLeft("Invalid input: %")
    }

    "raise expected error for / 2_ 1" in {
      PrefixSolver("/ 2_ 1") aka "result" must beLeft("Invalid input: 2_")
    }
  }

  "unsplitted operations" should {
    "raise expected error for +- 1 2 3" in {
      PrefixSolver("+- 1 2 3") aka "result" must beLeft("Invalid input: +-")
    }
  }
}
