### A Pluto.jl notebook ###
# v0.12.17

using Markdown
using InteractiveUtils

# This Pluto notebook uses @bind for interactivity. When running this notebook outside of Pluto, the following 'mock version' of @bind gives bound variables a default value (instead of an error).
macro bind(def, element)
    quote
        local el = $(esc(element))
        global $(esc(def)) = Core.applicable(Base.get, el) ? Base.get(el) : missing
        el
    end
end

# ╔═╡ 11c220d0-3f0a-11eb-0f95-81655d3c4296
begin 
	using Pkg
	using LsqFit
	using CSV
	using PlutoUI
	using Plots
	using LsqFit
	import Pkg; Pkg.add("ORCA")
	using ORCA
	plotly()
	theme(:bright)
end

# ╔═╡ 90160180-3f10-11eb-064a-3d4af2092661
using DataFrames

# ╔═╡ 0b74291e-3fd8-11eb-311a-e557d812f04f
md""" # Isotherms of Real Gases - W12e
"""

# ╔═╡ 4ba575c0-3fd9-11eb-1121-59cc48d2aa29
md""" Importing Experimental Data Bellow """

# ╔═╡ c6e9a67e-3f10-11eb-17e2-1b59c0ac5979
begin 
	csv_file=CSV.File("P_Data.csv")
	data_balls=DataFrame(csv_file)
end

# ╔═╡ 62bf8b40-3fdb-11eb-00af-c7847576c4a1
md"""
#### 1. 
###### Measuring the isotherms of a substance for eight temperatures.

"""

# ╔═╡ c45a1dc0-3fdb-11eb-3a9f-93c56356dcb7
md"""As the pressure is Close to the critical point, the substance is a mix of solid and liquid states. As a plot projection, this can be seen as the sudden flattening of the slopes in the Figure below, i.e constant pressure value for a changing volume. This flattening of the curve or the width, ΔV, of the flat slope gets smaller and smaller as the temperature is increased.
"""

# ╔═╡ 78dfaa0e-3f11-11eb-3c0b-13751376d736
begin
	volume=data_balls[:,1]
	pp=ones(7)
end

# ╔═╡ efe52d60-3f11-11eb-3454-4321e845726f
begin 
	p10=data_balls[:,2]
	p15=data_balls[:,3]
	p20=data_balls[:,4]
	p25=data_balls[:,5]
	p30=data_balls[:,6]
	p35=data_balls[:,7]
	p40=data_balls[:,8]
	p45=data_balls[:,9]
	p50=data_balls[:,10]
	p55=data_balls[:,11]
end

# ╔═╡ 1b31a0b0-3fe5-11eb-26f2-75e829d540cf
md"""
#### 2.
###### Plotting isotherms and determining the saturation vapour pressure $p_{s}$ in the region of Maxwell line. 
"""

# ╔═╡ 8b472200-3fd9-11eb-3540-35fc8796080b
md""" Slider to fetch the data at palce of intrest on the graph"""

# ╔═╡ c17e8710-3f15-11eb-06a8-377bea913121
@bind i Slider(1.0:0.01:51.0, show_value=true)

# ╔═╡ 6e6e0f80-3f12-11eb-0669-11a1ebdfdcb6
begin
	scatter(volume, p10,label="T = 283.15 K", size(1000,1000),xlabel="Volume [ml]",ylabel="Pressure [Bar]",title="Isotherms")
	scatter!(volume, p15,label ="T = 288.15 K")
	scatter!(volume, p20,label ="T = 293.15 K")
	scatter!(volume, p25,label ="T = 298.15 K")
	scatter!(volume, p30,label ="T = 303.15 K")
	scatter!(volume, p35,label ="T = 308.15 K")
	scatter!(volume, p40,label ="T = 313.15 K")
	plot!(volume, p45,label ="T = 318.15 K")
	plot!(volume, p50,label ="T = 323.15 K")
	plot!(volume, p55,label ="T = 328.15 K")
	plot!(volume, ones(length(volume))*i, label="Search Parameter",color="red")
end

# ╔═╡ 965fdfc0-3fdd-11eb-123b-83a7c8995d34
begin
	md""" Above is the plot of pressure against volume measurements of all the given temperatures. It can be seen that the flattened slopes are not a straight line along the x-axis and have a slight tilt along the y-axis. For this reason, a slider is coded in to find the areas of interest within a particular temperature plot. Once we determined the start and finish of a flattened slope for a particular temperature, we take the average of the corresponding y-axis values, i.e presure value."""
	
end

# ╔═╡ 46a1b8c0-3fe0-11eb-1da7-21c18e2af4d7
md"""Below is the table of final obtained values of saturation pressure to the corresponding temperature.
"""

# ╔═╡ f2f5eb90-3fdc-11eb-0651-0f4ccd11b91d
md"
| Temperature [°C]|T=10|T= 15|T=20|T=25|T=30|T=35|T=40|T=45|T=50|T=55|
|:---------- | ---------- |:------------:|:------------:|:------------:|:------------:|:------------:|:------------:|:------------:|:------------:|:------------:|
| Average saturation pressure( $P_{s}$)[Bar]   |16.342|18.525|21.25|23.783|26.774|30.164|33.332|36.37|N.A|N.A|"

# ╔═╡ d8ac8e1e-3fe5-11eb-04ae-23a91207b26a


# ╔═╡ 4ae5ebd0-3f14-11eb-0960-1f0c15803f6e
pp[1]=sum(p10[27:36])/length(p10[27:36]) #takes the average of these values

# ╔═╡ d1c9a000-3f1f-11eb-04aa-a3a91069a117
pp[2]=sum(p15[length(p15)-11:length(p15)-4])/length(p15[length(p15)-11:length(p15)-4])

# ╔═╡ 1f1930a0-3f20-11eb-3363-017de74e67cb
pp[3]=sum(p20[length(p20)-10:length(p20)-1])/length(p20[length(p20)-10:length(p20)-1])

# ╔═╡ d82f6460-3f20-11eb-19d6-0311a460626c
pp[4]=sum(p25[length(p25)-8:length(p25)-1])/length(p25[length(p25)-8:length(p25)-1])

# ╔═╡ 049f9510-3f21-11eb-2761-cfd06fe0581d
pp[5]=sum(p30[length(p30)-6:length(p30)-2])/length(p30[length(p30)-6:length(p30)-2])

# ╔═╡ 36fe05a0-3f21-11eb-02a1-c7d3c53e620d
pp[6]=sum(p35[length(p35)-5:length(p35)-1])/length(p35[length(p35)-5:length(p35)-1])

# ╔═╡ 733d25f0-3f21-11eb-2218-733176e04d91
pp[7]=sum(p40[length(p40)-5:length(p40)-1])/length(p40[length(p40)-5:length(p40)-1])

# ╔═╡ a2671f72-3f21-11eb-198a-7d06b64945c0
T=[283.15,288.15,293.15,298.15,303.15,308.15,313.15]

# ╔═╡ 0695a330-3fe6-11eb-261b-3b67f9cb37a2
md"""
#### 3.
###### Plotting $ln(p_{s})$ as function of "1/T". Fitting this plot with the vapour pressure equation to determine the average molar latent heat of vaporization of the substance under study i.e $Q_{23}$
"""

# ╔═╡ c66fcbb0-3f49-11eb-0266-77f3af791ede
begin
	@. linefittwo(c,stuff)=stuff[1]*c + stuff[2]
	ran2=[1.2,1.0]
	fit2= curve_fit(linefittwo, T, pp,ran2)
end

# ╔═╡ c9db3110-3f24-11eb-1ba0-a573c23d3e52
begin
	scatter(T,pp,xlabel="Temprature [K]",ylabel="Pressure [Bar] p_s",title="Fit to obtain dPs/dt",label="Data")
	plot!(T,linefittwo(T,fit2.param),label="Fit")
end

# ╔═╡ 08fb7880-3f4a-11eb-346f-d9b48ad08b75
dpdt = fit2.param[1]

# ╔═╡ 6322d140-3f28-11eb-1f4e-b91df2075bbb
begin
	@. linefit(c,stuff)=stuff[1]*c + stuff[2]
	ran=[1.2,1.0]
	fit1= curve_fit(linefit, (1 ./T), log.(pp),ran)
end

# ╔═╡ 04800250-3f25-11eb-257c-f9fcaa3545a1
begin
	scatter((1 ./T),log.(pp),xlabel="1/T [1/K]",ylabel="ln(p_s)",label="Data",title="ln(p_s) vs 1/T")
	plot!((1 ./T), linefit((1 ./T),fit1.param),label="Fit")
end

# ╔═╡ da27d190-3fe7-11eb-18b1-c3db0fa715b4
Slope=fit1.param[1]

# ╔═╡ 0b47a7a0-3fe8-11eb-0887-893b0e09b612
md"""
$ln(p_{s})=\frac{Q_{23}}{R} \cdot \frac{1}{T} + ln(p_{s0})$
Using the above formula $Q_{23}$ can be equated with the slope of the fit
"""

# ╔═╡ aee778e0-3fe8-11eb-19ee-69d8945df536
md"""
The Calculated value  $ Q_{23} = (1.7236 \pm 0.01) \cdot \frac{J}{mol} $
"""

# ╔═╡ b3f48b10-3fe9-11eb-15ef-290fac2e72fb
md"""
#### 4.
###### Determining the amount of the substance under study. 
"""

# ╔═╡ 33261e60-3fec-11eb-23be-d163d5a5432a
@bind j Slider(0.0:0.001:3.9, show_value=true)

# ╔═╡ 37360160-3f28-11eb-0c72-6bb2081e3661
begin
	plot((1 ./volume),(p55.*volume)/10,color="black",label="Data",xlabel="1/V [1/m^3]", ylabel="p.V [Pa]", title ="In search for constant P.V")
	plot!((1 ./volume),ones(length(volume))*j,color="red",label="Lim v→∞ (pV)")
end


# ╔═╡ 74b765a0-3fec-11eb-1ad2-09b9629bed47
md"""Interpreting from the equation $lim_{v→∞}(p.V)=nRT$, we particularly look for a region where the P.V value approximately stabilizes around a constant value, i.e value of P.V when $V→∞$.  
"""

# ╔═╡ 660dedc0-3fed-11eb-1080-d97ab9cc41e8
md"""
Further using $n=\frac{p.V}{RT}$
"""

# ╔═╡ 8aef4df0-3fed-11eb-34db-01a6f9c9e29e
md""" we obtain the calulated value of  $n=(1537\pm5)\cdot 10^{-6} mol$
"""

# ╔═╡ d57907d0-3fed-11eb-012a-7fe24ba32f22
md"""
#### 5.
###### Use the Clausius-Clapeyron equation to determine the molar heat of vaporization as a function of temperature. Plot the latent heat as a function of the reduced temperature $\frac{T}{T_{K}}$ and make a power fit on the data.

"""

# ╔═╡ 20ad80a0-3fee-11eb-0f92-edc10c1028c5
md"""
$Q_{23}(T)=\frac{dp_{s}}{dT}\cdot T \frac{ΔV_{m}}{n} [1]$
$as . ΔV=V_g - V_l$  
$and . \frac{dp_{s}}{dT}=p_{s0}\cdot \frac{Q_{23}}{RT_{2}} \cdot e^{-Q_{23}/RT}$
$ΔV_m= \frac{V_g - V_l}{n}$
"""

# ╔═╡ b5a778ee-3fee-11eb-18e7-87f1306932c3
md""" we can use Equation [1] to plot $ Q_23$ as a function of 'T'. To get further we also need to find the values of ΔV, this is done using the graph below. Using the slider different region of interest is examined; After the values around are searched for the best results and line is plotted as a reference.
"""

# ╔═╡ 75f4fa80-3f43-11eb-058e-97fb4d8a28ed
@bind o Slider(0.0:0.01:4.0, show_value=true)

# ╔═╡ 75e646c0-3f3e-11eb-184a-4f1f0f41c9a6
begin
	scatter(volume, p10,label="T = 283.15 K", size(1000,1000),xlabel="Volume [ml]",ylabel="Pressure [Bar]",title="Isotherms")
	scatter!(volume, p15,label ="T = 288.15 K")
	scatter!(volume, p20,label ="T = 293.15 K")
	scatter!(volume, p25,label ="T = 298.15 K")
	scatter!(volume, p30,label ="T = 303.15 K")
	scatter!(volume, p35,label ="T = 308.15 K")
	scatter!(volume, p40,label ="T = 313.15 K")
	plot!(volume, p45,label ="T = 318.15 K")
	plot!(volume, p50,label ="T = 323.15 K")
	plot!(volume, p55,label ="T = 328.15 K")
	plot!(ones(length(volume))*o, p40, label="Search Parameter",color="red")
	plot!(ones(length(volume))*0.5,p10,color="blue")
	plot!(ones(length(volume))*1.7,p10,color="blue")
	plot!(ones(length(volume))*0.505,p15,color="orange")
	plot!(ones(length(volume))*1.45,p15,color="orange")
	plot!(ones(length(volume))*0.509,p20,color="green")
	plot!(ones(length(volume))*1.32,p20,color="green")
	plot!(ones(length(volume))*0.51,p25,color="purple")
	plot!(ones(length(volume))*1.12,p25,color="purple")
	plot!(ones(length(volume))*0.511,p30,color="brown")
	plot!(ones(length(volume))*0.94,p30,color="brown")
	plot!(ones(length(volume))*0.511,p35,color="green")
	plot!(ones(length(volume))*0.81,p35,color="green")
	plot!(ones(length(volume))*0.512,p40,color="red")
	plot!(ones(length(volume))*0.68,p40,color="red")
	plot!(ones(length(volume))*0.6,p45,color="yellow")
end

# ╔═╡ 342f8710-3f47-11eb-30be-5fb3ea84f889
#0.5-1.7    -p10
#0.505-1.45 -p15
#0.509-1.32 -p20
#0.510-1.12 -p25
#0.511-0.94 -p30
#0.511-0.81 -p35
#0.512-0.68 -p40
#0.6 -p4
newp=[pp[:]; 36.37; pp[7];pp[6];pp[5];pp[4];pp[3];pp[2];pp[1]] #array concatination with ';'

# ╔═╡ 32a0e5e0-3f49-11eb-19d2-9930007fac5f
ΔV=abs.([0.5-1.7,0.505-1.45,0.509-1.32,0.510-1.12,0.511-0.94,0.511-0.81,0.512-0.68,0.0])

# ╔═╡ ee92fb50-3f47-11eb-281d-17d3af810948
newv=[0.5,0.505,0.509,0.510,0.511,0.511,0.512,0.6,0.68,0.81,0.94,1.12,1.32,1.45,1.7]

# ╔═╡ f146a9a0-3f47-11eb-2f07-d7f2786f5b5d
plot(newv, newp,title="ΔV(T) , volume against pressure",xlabel="Volume [ml]",ylabel="Pressure [Bar]")

# ╔═╡ 0b039a00-3f49-11eb-2206-ef5c9611c7fe
begin
	T2=[T; 318.15]
	plot(T2,ΔV,title="Temprature against ΔV(T)",xlabel="T [K]", ylabel="ΔV[m^3]")
end

# ╔═╡ 3aeba170-3f4b-11eb-27b9-2f8d0fff2e8e
begin
	n=0.001537651678
	Tk=318.15
	function Q23(T2) 
		T2.*(ΔV ./n).*fit2.param[1] 
	end #use dp/dt from the exp eqn.
end

# ╔═╡ adec9100-3f8e-11eb-0ffa-d5353c81febb
#make power fit anyway
begin
	huya=Q23(T2)
	@. powerfunc(t,stf)= stf[1]*t+stf[2]
	ranyolo=[0.9,0.37]
	powefit= curve_fit(powerfunc, T2, huya, ranyolo)
end

# ╔═╡ 22051a00-3ff1-11eb-14d1-7dd57fb3722f
begin
	huya22=Q23(T2)
	@. powerfunc22(t,stf)= stf[1]*t+stf[2]
	ranyolo22=[1.0,1.0]
	powefit22= curve_fit(powerfunc22, T2/Tk, huya22, ranyolo22)
end

# ╔═╡ 83b30d70-3ff1-11eb-0e11-d9842f434bc3
md"""
Though the Q-{23} is defined as 
$Q_{23}(T)=\frac{dp_{s}}{dT}\cdot T \frac{ΔV_{m}}{n} [1]$
we use the equation below to make power fit to the graph below
$Q-{23}=Q_{23}(0)\cdot (1-\frac{T}{T_{k}})^{3/8}$


"""

# ╔═╡ 5425f180-3f92-11eb-018a-73f6bb36d4d9
begin 
	scatter(T2,Q23(T2),title="Q23 as func. of T",xlabel="Temprature [K]",ylabel="Q23(T)", label="data")
	plot!(T2,powerfunc(T2,powefit.param),color="yellow",label="Fit")
end

# ╔═╡ 7173fab0-3f4d-11eb-38da-09a730f3db30
begin
	scatter(T2/Tk,Q23(T2/Tk),title="Q23 as func. of T/Tk",xlabel="T/Tk",ylabel="Q23(T) [J]")
	#plot!(T2/Tk,powerfunc22((T2/Tk),powefit22.param))
end

# ╔═╡ Cell order:
# ╠═0b74291e-3fd8-11eb-311a-e557d812f04f
# ╠═11c220d0-3f0a-11eb-0f95-81655d3c4296
# ╟─4ba575c0-3fd9-11eb-1121-59cc48d2aa29
# ╟─90160180-3f10-11eb-064a-3d4af2092661
# ╠═c6e9a67e-3f10-11eb-17e2-1b59c0ac5979
# ╠═62bf8b40-3fdb-11eb-00af-c7847576c4a1
# ╠═c45a1dc0-3fdb-11eb-3a9f-93c56356dcb7
# ╟─78dfaa0e-3f11-11eb-3c0b-13751376d736
# ╟─efe52d60-3f11-11eb-3454-4321e845726f
# ╠═1b31a0b0-3fe5-11eb-26f2-75e829d540cf
# ╟─8b472200-3fd9-11eb-3540-35fc8796080b
# ╟─c17e8710-3f15-11eb-06a8-377bea913121
# ╠═6e6e0f80-3f12-11eb-0669-11a1ebdfdcb6
# ╟─965fdfc0-3fdd-11eb-123b-83a7c8995d34
# ╟─46a1b8c0-3fe0-11eb-1da7-21c18e2af4d7
# ╠═f2f5eb90-3fdc-11eb-0651-0f4ccd11b91d
# ╠═d8ac8e1e-3fe5-11eb-04ae-23a91207b26a
# ╠═4ae5ebd0-3f14-11eb-0960-1f0c15803f6e
# ╠═d1c9a000-3f1f-11eb-04aa-a3a91069a117
# ╠═1f1930a0-3f20-11eb-3363-017de74e67cb
# ╠═d82f6460-3f20-11eb-19d6-0311a460626c
# ╠═049f9510-3f21-11eb-2761-cfd06fe0581d
# ╠═36fe05a0-3f21-11eb-02a1-c7d3c53e620d
# ╠═733d25f0-3f21-11eb-2218-733176e04d91
# ╠═a2671f72-3f21-11eb-198a-7d06b64945c0
# ╠═0695a330-3fe6-11eb-261b-3b67f9cb37a2
# ╠═c66fcbb0-3f49-11eb-0266-77f3af791ede
# ╟─c9db3110-3f24-11eb-1ba0-a573c23d3e52
# ╠═08fb7880-3f4a-11eb-346f-d9b48ad08b75
# ╠═6322d140-3f28-11eb-1f4e-b91df2075bbb
# ╠═04800250-3f25-11eb-257c-f9fcaa3545a1
# ╟─da27d190-3fe7-11eb-18b1-c3db0fa715b4
# ╟─0b47a7a0-3fe8-11eb-0887-893b0e09b612
# ╟─aee778e0-3fe8-11eb-19ee-69d8945df536
# ╟─b3f48b10-3fe9-11eb-15ef-290fac2e72fb
# ╠═33261e60-3fec-11eb-23be-d163d5a5432a
# ╟─37360160-3f28-11eb-0c72-6bb2081e3661
# ╟─74b765a0-3fec-11eb-1ad2-09b9629bed47
# ╟─660dedc0-3fed-11eb-1080-d97ab9cc41e8
# ╟─8aef4df0-3fed-11eb-34db-01a6f9c9e29e
# ╟─d57907d0-3fed-11eb-012a-7fe24ba32f22
# ╟─20ad80a0-3fee-11eb-0f92-edc10c1028c5
# ╟─b5a778ee-3fee-11eb-18e7-87f1306932c3
# ╟─75f4fa80-3f43-11eb-058e-97fb4d8a28ed
# ╠═75e646c0-3f3e-11eb-184a-4f1f0f41c9a6
# ╟─342f8710-3f47-11eb-30be-5fb3ea84f889
# ╟─32a0e5e0-3f49-11eb-19d2-9930007fac5f
# ╟─ee92fb50-3f47-11eb-281d-17d3af810948
# ╠═f146a9a0-3f47-11eb-2f07-d7f2786f5b5d
# ╠═0b039a00-3f49-11eb-2206-ef5c9611c7fe
# ╟─3aeba170-3f4b-11eb-27b9-2f8d0fff2e8e
# ╟─adec9100-3f8e-11eb-0ffa-d5353c81febb
# ╟─22051a00-3ff1-11eb-14d1-7dd57fb3722f
# ╟─83b30d70-3ff1-11eb-0e11-d9842f434bc3
# ╟─5425f180-3f92-11eb-018a-73f6bb36d4d9
# ╟─7173fab0-3f4d-11eb-38da-09a730f3db30
