#include "ShiftRegisterGenerator.h"

ShiftRegisterGenerator::ShiftRegisterGenerator()
{
	this->starting_vector_ = INIT_VECTOR;
}

unsigned int ShiftRegisterGenerator::GetRandomNumber()
{
	unsigned int xor_p = 0x00000001 << (INIT_VECTOR_LENGTH - P);
	unsigned int xor_q = 0x00000001 << (INIT_VECTOR_LENGTH - Q);
	unsigned int xor_result = 0;
	for (int i = INIT_VECTOR_LENGTH; i < 32; ++i)
	{
		xor_result = (xor_p & this->starting_vector_) << P;
		xor_result = xor_result ^ ((xor_q & this->starting_vector_) << Q);
		xor_p = xor_p << 1;
		xor_q = xor_q << 1;
		this->starting_vector_ += xor_result;
	}
	xor_result = this->starting_vector_;
	this->starting_vector_ = this->starting_vector_ >> (32 - INIT_VECTOR_LENGTH);
	return xor_result;
}