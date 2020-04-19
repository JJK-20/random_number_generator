#include <iostream>
#include "RandomNumberGenerator.h"
#include "LinearGenerator.h"
#include "ShiftRegisterGenerator.h"

#define ITERATION_COUNTER_END 100000

int main()
{
	RandomNumberGenerator rng;

	LinearGenerator lg;
	rng.SetGeneratorType(&lg);
	for(int iteration_counter = 0; iteration_counter < ITERATION_COUNTER_END; ++iteration_counter)
	{
		std::cout << rng.rand() << std::endl;
	}
	std::cout << "press enter to continue";
	std::cin.ignore();

	ShiftRegisterGenerator srg;
	rng.SetGeneratorType(&srg);
	for (int iteration_counter = 0; iteration_counter < ITERATION_COUNTER_END; ++iteration_counter)
	{
		std::cout << rng.rand() << std::endl;
	}
	std::cout << "press enter to continue";
	std::cin.ignore();
}