#pragma once

#include "abstract_generator_type.h"

#define P 7
#define Q 3 
#define INIT_VECTOR 0x00000045
#define INIT_VECTOR_LENGTH 7

class ShiftRegisterGenerator : public AbstractGeneratorType
{
public:
	ShiftRegisterGenerator();
	unsigned int GetRandomNumber();
private:
	unsigned int starting_vector_;
};