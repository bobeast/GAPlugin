/*
 *
 * Licensed to the Apache Software Foundation (ASF) under one
 * or more contributor license agreements.  See the NOTICE file
 * distributed with this work for additional information
 * regarding copyright ownership.  The ASF licenses this file
 * to you under the Apache License, Version 2.0 (the
 * "License"); you may not use this file except in compliance
 * with the License.  You may obtain a copy of the License at
 *
 *   http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing,
 * software distributed under the License is distributed on an
 * "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY
 * KIND, either express or implied.  See the License for the
 * specific language governing permissions and limitations
 * under the License.
 *
*/

describe('Plugin object (window.plugins)', function () {
	it("should exist", function() {
        expect(window.plugins).toBeDefined();
	});

	it("should contain a gaPlugin object", function() {
        expect(window.plugins.gaPlugin).toBeDefined();
		expect(typeof window.plugins.gaPlugin == 'object').toBe(true);
	});

    it("should contain an init function", function() {
        expect(window.plugins.gaPlugin.init).toBeDefined();
        expect(typeof window.plugins.gaPlugin.init == 'function').toBe(true);
    });
    
    it("should contain a trackEvent function", function() {
        expect(window.plugins.gaPlugin.trackEvent).toBeDefined();
        expect(typeof window.plugins.gaPlugin.trackEvent == 'function').toBe(true);
    });
    
    it("should contain a setVariable function", function() {
        expect(window.plugins.gaPlugin.setVariable).toBeDefined();
        expect(typeof window.plugins.gaPlugin.setVariable == 'function').toBe(true);
    });
    
    it("should contain a trackPage function", function() {
        expect(window.plugins.gaPlugin.trackPage).toBeDefined();
        expect(typeof window.plugins.gaPlugin.trackPage == 'function').toBe(true);
    });
    
    it("should contain an exit function", function() {
        expect(window.plugins.gaPlugin.exit).toBeDefined();
        expect(typeof window.plugins.gaPlugin.exit == 'function').toBe(true);
    });    
});
