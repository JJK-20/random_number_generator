#include "RandomNumberGenerator.h"

unsigned int RandomNumberGenerator::rand()
{
	return this->generator_type_->GetRandomNumber();
}

void RandomNumberGenerator::SetGeneratorType(AbstractGeneratorType* generator_type)
{
	this->generator_type_ = generator_type;
}
