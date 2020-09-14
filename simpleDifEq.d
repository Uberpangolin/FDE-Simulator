import polynomial;
import numFunction;
import std.conv;

/* Simple Differential Equation
/  Defined as a differential equation whose matrix terms consist only of polynomials
/  Defined on also being homogenous
/
*/

class simpleDifEq {

	polynomial[int] differentialEquation;
	numFunction solution;
	int highestOrder = 0;

	//CONSTRUCTORS

	this() {}

	this(polynomial[int] differentialEquation) {
		this.differentialEquation = differentialEquation;
	}

	//MUTEX

	void setDifEq(polynomial[int] differentialEquation) {
		this.differentialEquation = differentialEquation;
		foreach(int ord; this.differentialEquation.byKey()) {
			highestOrder = (ord > highestOrder) ? ord : highestOrder;
		}
	}

	void setDifEqTerm(polynomial polynomial, int order) {
		this.differentialEquation[order] = polynomial;
	}

	//GETTERS

	polynomial[int] getDiffEq() {
		return this.differentialEquation;
	}

	polynomial getTerm(int order) {
		return this.differentialEquation[order];
	}

	//METHODS

	void addTerm(polynomial polynomial, int order) {
		this.differentialEquation[order] = polynomial;
		this.highestOrder = (this.highestOrder < order) ? order : this.highestOrder;
	}

	override string toString() {
		string str = "";
		foreach(int ord; this.differentialEquation.byKey()) {
			str = str ~ "(" ~ to!string(this.differentialEquation[ord]) ~ ")D^" ~ to!string(ord) ~ " + "; 
		}
		str = str[0 .. $ - 2];
		return str;
	}

	polynomial getPolynomial(int order) {
		return differentialEquation[order];
	}

	/*  This will solve a differential equation. The boundry conditions may be given or general boundry conditions may be specified in the flag
	*
	*	FLAG:
	*	Bit 1: Specifys that it approaches from infinity
	*	Bit 2: Specifys that the differential equation starts at x = 0 but that there is only a single boundry condition for x = 0
	*
	*	Boundry Conditions:
	*	Index 0 is defined as the boundry condition for the 0th derivative and so on
	*
	*/
	void solveDifferentialEquationSpecial(double[]* array, double[] boundryConditions, long flag) {
		double[] solution = *array;
		// Trial Stuff
		double offset = 40;
		double initialValue = 0.00000001;
		double stepSize = 0.001;
		int steps = 100000;
		//

		double stepOne;
		double stepTwo;
		double stepThree;
		double stepFour;

		stepOne = initialValue;
		stepTwo = stepOne;

		for(int i = steps - 1; steps > 0; steps++) {
			 
		}


	}

}