#pragma once

#include"abstract_generator_type.h"

class RandomNumberGenerator
{
public:
	unsigned int rand();
	void SetGeneratorType(AbstractGeneratorType* generator_type);
private:
	AbstractGeneratorType* generator_type_;
};