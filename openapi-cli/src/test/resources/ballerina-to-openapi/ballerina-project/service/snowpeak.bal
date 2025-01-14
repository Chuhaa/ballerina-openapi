// Copyright (c) 2021 WSO2 Inc. (http://www.wso2.org) All Rights Reserved.
//
// WSO2 Inc. licenses this file to you under the Apache License,
// Version 2.0 (the "License"); you may not use this file except
// in compliance with the License.
// You may obtain a copy of the License at
//
// http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing,
// software distributed under the License is distributed on an
// "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY
// KIND, either express or implied.  See the License for the
// specific language governing permissions and limitations
// under the License.

import ballerina/http;
import 'service.representations as rep;
import 'service.mock;

# A fake mountain resort
service /payloadV on new http:Listener(9090) {

    # Represents Snowpeak location resource
    #
    # + return - `Location` representation
    resource function get locations() returns @http:Cache rep:Locations {
        rep:Locations locations = mock:getLocations();
        return locations;
    }

    # Reperesents Snowpeak room collection resource
    #
    # + id - Unique identification of location
    # + startDate - Start date in format yyyy-mm-dd
    # + endDate - End date in format yyyy-mm-dd
    # + return - `Rooms` representation
    resource function get locations/[string id]/rooms(string startDate, string endDate)
                returns rep:Rooms {
        rep:Rooms rooms = mock:getRooms(startDate, endDate);
        return rooms;
    }

    # Represents Snowpeak reservation resource
    #
    # + reservation - Reservation representation
    # + return - `ReservationCreated` or ReservationConflict representation
    resource function post reservation(@http:Payload rep:Reservation reservation)
                returns @http:Cache{} rep:ReservationCreated|rep:ReservationConflict {
        rep:ReservationCreated created = mock:createReservation(reservation);
        return created;
    }

    # Represents Snowpeak reservation resource
    #
    # + reservation - Reservation representation
    # + return - `ReservationCreated` or ReservationConflict representation
    resource function put reservation(@http:Payload rep:Reservation reservation)
                returns rep:ReservationUpdated|rep:ReservationConflict {
        rep:ReservationUpdated updated = mock:updateReservation(reservation);
        return updated;
    }

    # Represents Snowpeak payment resource
    #
    # + id - Unique identification of payment
    # + payment - Payment representation
    # + return - `PaymentCreated` or `PaymentConflict` representation
    resource function post payment/[string id](@http:Payload rep:Payment payment)
                returns rep:PaymentCreated|rep:PaymentConflict {
        rep:PaymentCreated paymentCreated = mock:createPayment(id, payment);
        return paymentCreated;
    }
}
