#include "Alpha.H"

using namespace Foam;

preciceAdapter::FF::Alpha::Alpha(
    const Foam::fvMesh& mesh,
    const std::string nameAlpha)
: Alpha_(
    const_cast<volScalarField*>(
        &mesh.lookupObject<volScalarField>(nameAlpha)))
{
    dataType_ = scalar;
}

std::size_t preciceAdapter::FF::Alpha::write(double* buffer, bool meshConnectivity, const unsigned int dim)
{
    int bufferIndex = 0;

    if (this->locationType_ == LocationType::volumeCenters)
    {
        if (cellSetNames_.empty())
        {
            for (const auto& cell : Alpha_->internalField())
            {
                buffer[bufferIndex++] = cell;
            }
        }
        else
        {
            for (const auto& cellSetName : cellSetNames_)
            {
                cellSet overlapRegion(Alpha_->mesh(), cellSetName);
                const labelList& cells = overlapRegion.toc();

                for (const auto& currentCell : cells)
                {
                    // Copy the alpha valus into the buffer
                    buffer[bufferIndex++] = Alpha_->internalField()[currentCell];
                }
            }
        }
    }

    // For every boundary patch of the interface
    for (uint j = 0; j < patchIDs_.size(); j++)
    {
        int patchID = patchIDs_.at(j);

        // For every cell of the patch
        forAll(Alpha_->boundaryField()[patchID], i)
        {
            // Copy the Alpha into the buffer
            buffer[bufferIndex++] =
                Alpha_->boundaryField()[patchID][i];
        }
    }
    return bufferIndex;
}

void preciceAdapter::FF::Alpha::read(double* buffer, const unsigned int dim)
{
    int bufferIndex = 0;

    if (this->locationType_ == LocationType::volumeCenters)
    {
        if (cellSetNames_.empty())
        {
            for (auto& cell : Alpha_->internalField())
            {
                cell = buffer[bufferIndex++];
            }
        }
        else
        {
            for (const auto& cellSetName : cellSetNames_)
            {
                cellSet overlapRegion(Alpha_->mesh(), cellSetName);
                const labelList& cells = overlapRegion.toc();

                for (const auto& currentCell : cells)
                {
                    // Copy the pressure into the buffer
                    Alpha_->internalField()[currentCell] = buffer[bufferIndex++];
                }
            }
        }
    }

    // For every boundary patch of the interface
    for (uint j = 0; j < patchIDs_.size(); j++)
    {
        int patchID = patchIDs_.at(j);
        // For every cell of the patch
        forAll(Alpha_->boundaryField()[patchID], i)
        {
            Alpha_->boundaryField()[patchID][i] = buffer[bufferIndex++];
        }
    }
}

bool preciceAdapter::FF::Alpha::isLocationTypeSupported(const bool meshConnectivity) const
{
    if (meshConnectivity)
    {
        return (this->locationType_ == LocationType::faceCenters);
    }
    else
    {
        return (this->locationType_ == LocationType::faceCenters || this->locationType_ == LocationType::volumeCenters);
    }
}

std::string preciceAdapter::FF::Alpha::getDataName() const
{
    return "Alpha";
}
