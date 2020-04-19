#include "LinearGenerator.h"

LinearGenerator::LinearGenerator()
{
	this->previous_random_number_ = X0;
}

unsigned int LinearGenerator::GetRandomNumber()
{
	this->previous_random_number_ = A * this->previous_random_number_ + C; //when we go out of uint32 range we got %2^32-1 automatically
	return this->previous_random_number_;
}