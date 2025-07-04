import { useEffect, useState } from "react";
import { useNavigate, useParams } from "react-router-dom"

export default function EditCountry() {
    const {countryId} = useParams();
    const [country, setCountry] = useState({});
    const navigate = useNavigate();

    useEffect(() => {
            fetch(`http://localhost/countryOne/${countryId}`)
            .then((res) => {return res.json()})
            .then((data) => {setCountry(data)})
        }, []);

    function edit() {
        fetch("http://localhost/country", {
            method: "PATCH",
            headers: {"Content-Type": "application/json"},
            body: JSON.stringify({countryId: country.countryId, country: country.country})
        })
        .then((res) => {
            if(res.ok) {
                alert('수정 성공');
                navigate('/CountryOne/' + country.countryId);
            } else {
                alert('수정 실패');
            }
        })
    }

    return (
        <div className="flex flex-col items-center mt-6">
            <h1 className="text-2xl font-bold mb-4">
                EditCountry (countryId: {countryId})
            </h1>
            <div className="w-72">
                <label className="block text-sm font-medium text-gray-700 mb-1">country</label>
                <input type="text" className="w-full px-4 py-2 border border-gray-300 rounded-lg focus:outline-none focus:ring-2 focus:ring-blue-400" value={country.country}
                    onChange={(e) => setCountry({...country, country: e.target.value})}
                />
            </div>
            <button onClick={edit} className="mt-4 px-4 py-1 bg-blue-500 text-white font-semibold py-2 rounded-lg hover:bg-blue-600 transition">수정</button>
        </div>
    )
}
