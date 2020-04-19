#pragma once

#include "abstract_generator_type.h"

#define A 69069
#define C 1
#define X0 7

class LinearGenerator : public AbstractGeneratorType
{
public:
	LinearGenerator();
	unsigned int GetRandomNumber();
private:
	unsigned int previous_random_number_;
};
