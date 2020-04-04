/**
 * The MIT License
 * Copyright © 2017 DTL
 *
 * Permission is hereby granted, free of charge, to any person obtaining a copy
 * of this software and associated documentation files (the "Software"), to deal
 * in the Software without restriction, including without limitation the rights
 * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 * copies of the Software, and to permit persons to whom the Software is
 * furnished to do so, subject to the following conditions:
 *
 * The above copyright notice and this permission notice shall be included in
 * all copies or substantial portions of the Software.
 *
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 * AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
 * THE SOFTWARE.
 */
package nl.dtls.fairdatapoint.service.resource;

import nl.dtls.fairdatapoint.database.mongo.repository.ResourceDefinitionRepository;
import nl.dtls.fairdatapoint.entity.resource.ResourceDefinition;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.Optional;

import static java.lang.String.format;

@Service
public class ResourceDefinitionService {

    @Autowired
    private ResourceDefinitionRepository resourceDefinitionRepository;

    public ResourceDefinition getByUuid(String uuid) {
        Optional<ResourceDefinition> oRd = resourceDefinitionRepository.findByUuid(uuid);
        if (oRd.isEmpty()) {
            throw new IllegalStateException(
                    format("Resource with provided uuid ('%s') is not defined", uuid)
            );
        }
        return oRd.get();
    }

    public ResourceDefinition getByUriPrefix(String uriPrefix) {
        Optional<ResourceDefinition> oRd = resourceDefinitionRepository.findByUriPrefix(uriPrefix);
        if (oRd.isEmpty()) {
            throw new IllegalStateException(
                    format("Resource with provided uri prefix ('%s') is not defined", uriPrefix)
            );
        }
        return oRd.get();
    }

}
