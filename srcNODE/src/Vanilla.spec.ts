/* Copyright 2024 "Holloway" Chew; Kean Ho <hello@hollowaykeanho.com>
 *
 *
 * Licensed under the Apache License, Version 2.0 (the "License"); you may not
 * use this file except in compliance with the License. You may obtain a copy of
 * the License at:
 *
 *                  http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS, WITHOUT
 * WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied. See the
 * License for the specific language governing permissions and limitations under
 * the License.
 */
import * as hestiaERROR from "./Vanilla.js";
// Jasmine Test Framework




describe('enum "Error numbers"', () => {
	it("should have unique number for each unique key.", () => {
		let verdict = false;
		let index = 0;
		var registered = new Map();

		try {
			verdict = true;
			for (const [key, value] of Object.entries(hestiaERROR)) {
				if (registered.has(key)) {
					console.log("duplicated key: " + key);
					verdict = false;
					break;
				}

				index++;
				registered.set(key, value);
			}
		} catch (e) {
			verdict = false;
		}

		expect(verdict).toBe(true);
	});
});
