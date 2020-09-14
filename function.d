class functions{

	int length;

	//CONSTRUCTORS

	this(int length) {
		this.length = length;
		//double[length] value = double.nan; 
	}

	this() {
		this.length = length;
	}

	//GETERS

	int getLength() {
		return this.length;
	}

	//MUTEX

	void setLength(int length) {
		this.length = length;
	}

}