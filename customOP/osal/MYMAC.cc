/**
 * OSAL behavior definition file.
 */

#include "OSAL.hh"


DEFINE_STATE(ACCUMULATOR)

	SIntWord acc;
	SIntWord count;
	SIntWord max_count;

	INIT_STATE(ACCUMULATOR)

	acc = 0;
	count = 1;
	max_count = 4;

 	END_INIT_STATE;

END_DEFINE_STATE;



OPERATION_WITH_STATE(MY_MAC, ACCUMULATOR)
	TRIGGER

	// inputs
	SIntWord input1 = INT(1);
	SIntWord input2 = INT(2);

	if (STATE.count < STATE.max_count)
	{
		STATE.acc += (input1 * input2);
		IO(3) = STATE.acc;
	}
	else
	{
		STATE.acc += (input1 * input2);
		IO(3) = STATE.acc;

		STATE.count = 0;
		STATE.acc = 0;
	}



	STATE.count += 1;

	return true;

	END_TRIGGER;
END_OPERATION_WITH_STATE(MY_MAC)

