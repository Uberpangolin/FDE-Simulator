import polynomial;
import simpleDifEq;
import std.mathspecial;
import std.algorithm;

class ExtraMath {

	this() {}
	
	//METHODS
	simpleDifEq buildFractionDifEqRL(int order, double center, double dOrder) {
		simpleDifEq difEqRL = new simpleDifEq();
		double coefficient;
		for(int i = 0; i <= order; i++) {
			coefficient = gamma(dOrder+1)/(gamma(i+1)*gamma(dOrder-i+1)*gamma(i-dOrder+1));
			if(center == 0) {
			difEqRL.addTerm(new polynomial(coefficient, i-dOrder), i);
			}
			else {
				polynomial poly = new polynomial(coefficient, 1, i-dOrder);
				poly.addTerm(center, 0);
			}
		}
		return difEqRL;
	}

	//ONLY DO LESS THAN q = 3

	simpleDifEq buildFractionalDifEqCapS(int order, double center, double dOrder, double BCS) {
		//assert(order == BC.length)
		simpleDifEq difEqCap = new simpleDifEq();
		difEqCap = buildFractionDifEqRL(order, center, dOrder);
		polynomial poly = new polynomial();
		polynomial poly_t = new polynomial();
		//for(int j = 0; j <= cast(int)order; j++) {
		//double coefficient = -gamma(dOrder+1)/(gamma(i+1)*gamma(dOrder-i+1)*gamma(i-dOrder+1))/gamma(2-j)*BCS;
		//poly_t.addTerm(pow(coefficient, 1-dOrder),1);
		//poly_t.addTerm(pow(coefficient, 1-dOrder),1);
		//poly_t.power = 1-dOrder;


		//}


		return null;
	}

	simpleDifEq isolateHighestDerivative(simpleDifEq diffEq) {
		polynomial highestTerm = diffEq.getTerm(diffEq.highestOrder);
		highestTerm.denominator = true;
		diffEq.setDifEqTerm(new polynomial(1,0), diffEq.highestOrder);
		foreach(int ord; diffEq.differentialEquation.byKey()) {
			if(ord == diffEq.highestOrder) {}
			else {
				diffEq.addTerm(highestTerm, -1 * ord);
			}
		}
		return diffEq;
	}

	polynomial combinePolynomial(polynomial p1, polynomial p2) {
		polynomial output = new polynomial();
		foreach(double ord; p1.polynomial.byKey()) {
			output.addTerm(p1.polynomial[ord], ord);
		}
		foreach(double ord; p2.polynomial.byKey()) {
			if(!p1.polynomial.keys.canFind(ord)) {
			output.addTerm(p2.polynomial[ord], ord);
			}
			else {
			output.addTerm(p2.polynomial[ord] + p1.polynomial[ord], ord);
			}
		}
		return output;
	}

	simpleDifEq combineDifEq(simpleDifEq d1, simpleDifEq d2) {
		simpleDifEq output = new simpleDifEq();
		foreach(int ord; d1.differentialEquation.byKey()) {
			output.addTerm(d1.differentialEquation[ord], ord);
		}
		foreach(int ord; d2.differentialEquation.byKey()) {
			if(!d1.differentialEquation.keys.canFind(ord)) {
				output.addTerm(d2.differentialEquation[ord], ord);
			}
			else {
				output.addTerm(combinePolynomial(d1.differentialEquation[ord], d2.differentialEquation[ord]), ord);
			}
		}
		return output;
	}

}